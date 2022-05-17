import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postplus_app/update_password/update_password.dart';
import '../my_widgets/my_elevated_button_widget.dart';
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
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Change Password",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 30),
                ),
                const SizedBox(
                  height: 16,
                ),
                MyTextFieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(" ")),
                  ],
                  maxLength: 20,
                  obscureText: true,
                  label: "New password",
                  hint: "type your new password here",
                  onChanged: (text) {},
                  controller: _newPasswordController,
                  errorText: newPasswordErrorText,
                  showErrorText: _newPasswordController.text.isEmpty,
                ),
                MyTextFieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(" ")),
                  ],
                  maxLength: 20,
                  obscureText: true,
                  label: "Confirm password",
                  hint: "Confirm your new password here",
                  onChanged: (text) {
                    setState(() {});
                  },
                  controller: _confirmPasswordController,
                  errorText: confirmPasswordErrorText,
                  showErrorText:
                      _confirmPasswordController == _newPasswordController,
                ),
                MyElevatedButtonWidget(
                  title: "Update password",
                  action: _newPasswordController.text ==
                          _confirmPasswordController.text
                      ? () async {
                          await updatePassword(widget.currentUserModel,
                              _newPasswordController.text);
                          Navigator.pop(context);
                        }
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
