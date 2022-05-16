import 'package:flutter/material.dart';
import 'package:postplus_app/my_home_page/my_home_page.dart';
import 'package:postplus_app/my_login_page/my_google_login/my_google_login.dart';
import 'package:postplus_app/my_register_page/my_register_page.dart';
import 'package:postplus_app/my_widgets/my_elevated_button_widget.dart';
import 'package:postplus_app/my_widgets/my_text_button_widget.dart';
import 'package:postplus_app/my_widgets/my_textfield_widget.dart';
import 'package:postplus_app/post_my_login/post_my_login.dart';
import 'package:postplus_app/user_model/user_model.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "images/logo.png",
                  width: 200,
                  height: 200,
                ),
                const Text("Wellcome"),
                const Text("Sign in with email"),
                MyTextFieldWidget(
                  hint: 'Please type your email',
                  label: 'Email',
                  onChanged: (text) {
                    email = text;
                  },
                  obscureText: false,
                ),
                MyTextFieldWidget(
                  hint: 'Please type your password',
                  label: 'Password',
                  obscureText: true,
                  onChanged: (text) {
                    password = text;
                  },
                ),
                MyTextButtonWidget(
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyRegisterPage(title: "Register"),
                        ),
                      );
                    },
                    title: "First time here? Register"),
                MyElevatedButtonWidget(
                    action: () async {
                      final currentUser = await postMyLogin(
                          UserModel(email: email, password: password));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(currentUserModel: currentUser),
                        ),
                      );
                    },
                    title: 'Sign in'),
                const Text("or"),
                Container(
                  color: Colors.black,
                  height: 2,
                  width: MediaQuery.of(context).size.width*0.7,
                ),
                const Text("Sign in with Google"),
                const LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
