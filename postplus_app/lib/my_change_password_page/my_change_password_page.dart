import 'package:flutter/material.dart';

import '../my_widgets/my_textfield_widget.dart';
import '../user_model/user_model.dart';

class MyChangePasswordPage extends StatefulWidget {
  final UserModel currentUserModel;
  const MyChangePasswordPage({Key? key, required this.currentUserModel})
      : super(key: key);

  @override
  State<MyChangePasswordPage> createState() => _MyChangePasswordPageState();
}

class _MyChangePasswordPageState extends State<MyChangePasswordPage> {
  String newPasswordErrorText = "Required field";
  String confirmPasswordErrorText = "Passwords do not match";
  final TextEditingController _newPasswordController = TextEditingController(text: "");
  final TextEditingController _confirmPasswordController = TextEditingController(text: "");



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MyTextFieldWidget(
              obscureText: false,
              label: "New password",
              hint: "type your new password here",
              onChanged: (text) {},
              controller: _newPasswordController,
              errorText: newPasswordErrorText,
              showErrorText: _newPasswordController.text.isEmpty,
            ),
            MyTextFieldWidget(
              obscureText: false,
              label: "Confirm password",
              hint: "Confirm your new password here",
              onChanged: (text) {
                setState(() {});
              },
              controller: _confirmPasswordController,
              errorText: confirmPasswordErrorText,
              showErrorText: _confirmPasswordController == _newPasswordController,
            ),
            ElevatedButton(
              child: const Text("Update password"),
              onPressed: _newPasswordController == _confirmPasswordController
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
