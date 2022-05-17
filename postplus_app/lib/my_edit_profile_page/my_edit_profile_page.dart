import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postplus_app/my_change_password_page/my_change_password_page.dart';
import 'package:postplus_app/my_widgets/my_elevated_button_widget.dart';
import 'package:postplus_app/my_widgets/my_textfield_widget.dart';
import 'package:postplus_app/user_model/user_model.dart';

import '../my_themes/my_app_theme.dart';

class MyEditProfilePage extends StatefulWidget {
  final UserModel currentUserModel;
  const MyEditProfilePage({Key? key, required this.currentUserModel})
      : super(key: key);

  @override
  State<MyEditProfilePage> createState() => _MyEditProfilePageState();
}

class _MyEditProfilePageState extends State<MyEditProfilePage> {
  String usernameErrorText = "Required field";
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();

  @override
  void initState() {
    _userNameController.text = widget.currentUserModel.username!;
    if (widget.currentUserModel.biography != null) {
      _biographyController.text = widget.currentUserModel.biography!;
    } else {
      _biographyController.text = "";
    }

    super.initState();
  }

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
                    "Edit Profile",
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
                      FilteringTextInputFormatter.allow(RegExp("[a-z0-9]")),
                    ],
                    maxLength: 20,
                    obscureText: false,
                    label: "@username*",
                    hint: "type a username here",
                    onChanged: (text) {
                      setState(() {});
                    },
                    controller: _userNameController,
                    errorText: usernameErrorText,
                    showErrorText: _userNameController.text.isEmpty,
                  ),
                  MyTextFieldWidget(
                      maxLength: 300,
                      obscureText: false,
                      label: "Biography",
                      hint: "Tell they more about you...",
                      onChanged: (text) {},
                      controller: _biographyController),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyChangePasswordPage(
                              currentUserModel: widget.currentUserModel),
                        ),
                      );
                    },
                    child: Text(
                      "Change password",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                  MyElevatedButtonWidget(
                    title: "Update",
                    action: () {
                      if (_userNameController.text.isNotEmpty) {
                        try {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(widget.currentUserModel.sId!)
                              .update({
                            "biography": _biographyController.text,
                            "username": _userNameController.text,
                          });
                          Navigator.pop(context);
                        } catch (e) {
                          return null;
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
