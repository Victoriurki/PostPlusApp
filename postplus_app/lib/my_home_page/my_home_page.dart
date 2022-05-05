import 'package:flutter/material.dart';
import 'package:postplus_app/my_register_page/my_register_page.dart';
import 'package:postplus_app/my_widgets/my_elevated_button_widget.dart';
import 'package:postplus_app/my_widgets/my_text_button_widget.dart';
import 'package:postplus_app/my_widgets/my_textfield_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          ],
        ),
      ),
    );
  }
}
