import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postplus_app/my_home_page/my_home_page.dart';
import 'package:postplus_app/my_login_page/my_google_login/my_google_login.dart';
import 'package:postplus_app/my_register_page/my_register_page.dart';
import 'package:postplus_app/my_themes/my_app_theme.dart';
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
      child: Container(
         decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                MyAppTheme.backgroundGradientColorA,
                MyAppTheme.backgroundGradientColorB,
              ],
            ),
          ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "images/logo.png",
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    "Wellcome",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Sign in with email",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextFieldWidget(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(" ")),
                    ],
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
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(" ")),
                    ],
                    maxLength: 20,
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
                  const SizedBox(
                    height: 8,
                  ),
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
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "or",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: MyAppTheme.greyColor,
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Sign in with Google",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const LoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
