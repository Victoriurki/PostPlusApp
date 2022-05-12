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
    return Scaffold(
      body: Center(
        child: Column(
          children: [
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
                title: "Register"),
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
                title: 'Sing in'),
            const LoginButton()
          ],
        ),
      ),
    );
  }
}
