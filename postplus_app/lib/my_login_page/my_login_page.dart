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
  String loginErrorText = "Required field";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  controller: _emailController,
                  errorText: loginErrorText,
                  showErrorText: _emailController.text.isEmpty,
                  hint: 'Please type your email',
                  label: 'Email',
                  onChanged: (text) {
                    setState(() {});
                  },
                  obscureText: false,
                ),
                MyTextFieldWidget(
                  controller: _passwordController,
                  errorText: loginErrorText,
                  showErrorText: _passwordController.text.isEmpty,
                  hint: 'Please type your password',
                  label: 'Password',
                  obscureText: true,
                  onChanged: (text) {
                    setState(() {});
                  },
                ),
                MyTextButtonWidget(
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const MyRegisterPage(title: "Register"),
                        ),
                      );
                    },
                    title: "First time here? Register"),
                MyElevatedButtonWidget(
                    action: (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty)
                        ? () async {
                            final currentUser = await postMyLogin(UserModel(
                                email: _emailController.text,
                                password: _passwordController.text));
                            if (currentUser.hasError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Invalid email or password"),
                                ),
                              );
                            } else {
                              await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                      currentUserModel: currentUser.data!),
                                ),
                              );
                            }
                          }
                        : null,
                    title: 'Sign in'),
                const Text("or"),
                Container(
                  color: Colors.black,
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.7,
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
