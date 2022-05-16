import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/my_change_password_page/my_change_password_page.dart';
import 'package:postplus_app/my_widgets/my_textfield_widget.dart';
import 'package:postplus_app/user_model/user_model.dart';

class MyEditProfilePage extends StatefulWidget {
  final UserModel currentUserModel;
  const MyEditProfilePage({Key? key, required this.currentUserModel})
      : super(key: key);

  @override
  State<MyEditProfilePage> createState() => _MyEditProfilePageState();
}

class _MyEditProfilePageState extends State<MyEditProfilePage> {
  String usernameErrorText = "Required field";
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _biographyController = TextEditingController();

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
      child: Scaffold(
        body: Column(
          children: [
            MyTextFieldWidget(
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
              child: const Text("Change password"),
            ),
            ElevatedButton(
              child: const Text("Update"),
              onPressed: _userNameController.text.isNotEmpty
                  ? () {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.currentUserModel.sId!)
                          .update({
                        "biography": _biographyController.text,
                        "username": _userNameController.text,
                      });
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
