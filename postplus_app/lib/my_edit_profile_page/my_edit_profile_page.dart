import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  String? biography;
  String? username;
  String usernameErrorText = "Required field";
  bool biographyError = false;
  bool usernameError = false;

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
                username = text;
                usernameError = false;
              },
              controller:
                  TextEditingController(text: widget.currentUserModel.username),
              errorText: usernameErrorText,
              showErrorText: usernameError,
            ),
            MyTextFieldWidget(
              obscureText: false,
              label: "Biography",
              hint: "Tell they more about you...",
              onChanged: (text) {
                biography = text;
                biographyError = false;
              },
              controller: TextEditingController(
                  text: widget.currentUserModel.biography),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Change password"),
            ),
            ElevatedButton(
                child: const Text("Update"),
                onPressed: () {
                  if (username == null && biography == null) {
                    Navigator.pop(context);
                  }
                  if (username == "" && biography == "") {
                    usernameError = true;
                    setState(() {});
                  }
                  if (username == "" && biography != null && biography != "") {
                    usernameError = true;
                    setState(() {});
                  }
                  if (username != null && username != "" && biography == "") {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.currentUserModel.sId!)
                        .update({
                      "biography": biography,
                      "username": username,
                    });
                    Navigator.pop(context);
                  }
                  if (username == "" && biography == null) {
                    usernameError = true;
                    setState(() {});
                  }
                  if (username != null && username != "" && biography == null) {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.currentUserModel.sId!)
                        .update({
                      "username": username,
                    });
                    Navigator.pop(context);
                  }
                  if (username == null && biography != null) {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.currentUserModel.sId!)
                        .update({
                      "biography": biography,
                    });
                    Navigator.pop(context);
                  }
                })
          ],
        ),
      ),
    );
  }
}
