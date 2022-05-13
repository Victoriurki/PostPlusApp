import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/my_widgets/my_textfield_widget.dart';
import 'package:postplus_app/user_model/user_model.dart';

class MyEditProfilePage extends StatefulWidget {
  final UserModel currentUserModel;
  const MyEditProfilePage({Key? key, required this.currentUserModel}) : super(key: key);

  @override
  State<MyEditProfilePage> createState() => _MyEditProfilePageState();
}

class _MyEditProfilePageState extends State<MyEditProfilePage> {
  String biography = "";
  String username = "";
  String biographyErrorText = "Campo obrigatório";
  String usernameErrorText = "Campo obrigatório";
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
                label: "Biography",
                hint: "Tell they more about you...",
                onChanged: (text) {
                  biography = text;
                  biographyError = false;
                }),
            MyTextFieldWidget(
                obscureText: false,
                label: "@username",
                hint: "type a username here",
                onChanged: (text) {
                  username = text;
                  usernameError = false;
                }),
            TextButton(
              onPressed: () {},
              child: const Text("Change password"),
            ),
            ElevatedButton(
              child: const Text("Update"),
              onPressed: () {
                if (username.isEmpty || username == "") {
                  usernameError = true;
                  setState(() {});
                }
                if (biography.isEmpty || biography == "") {
                  biographyError = true;
                  setState(() {});
                }
                if (usernameError == false && biographyError == false) {
                  // FirebaseFirestore.instance.doc("users").collection(widget.currentUserModel.sId!).
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
