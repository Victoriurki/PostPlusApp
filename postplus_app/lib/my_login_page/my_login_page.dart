import 'package:flutter/material.dart';
import 'package:postplus_app/my_login_page/my_google_login/my_google_login.dart';
import 'package:postplus_app/my_register_page/my_register_page.dart';
import 'package:postplus_app/my_widgets/my_elevated_button_widget.dart';
import 'package:postplus_app/my_widgets/my_text_button_widget.dart';
import 'package:postplus_app/my_widgets/my_textfield_widget.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
                action: () {
                  print('$email $password');
                },
                title: 'Sing in'),
            const LoginButton()
          ],
        ),
      ),
    );
  }
}
