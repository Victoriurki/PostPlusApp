import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../user_model/user_model.dart';

class MyUpdateProfilePicturePage extends StatefulWidget {
  final UserModel currentUserModel;
  const MyUpdateProfilePicturePage({Key? key, required this.currentUserModel})
      : super(key: key);

  @override
  State<MyUpdateProfilePicturePage> createState() => _MyUploadImagePageState();
}

class _MyUploadImagePageState extends State<MyUpdateProfilePicturePage> {
  String description = '';
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                                leading: const Icon(Icons.photo_camera),
                                title: const Text("Tirar foto"),
                                onTap: () async {
                                  try {
                                    final image = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    if (image == null) return;
                                    final imageTemporary = File(image.path);
                                    setState(() {
                                      this.image = imageTemporary;
                                    });
                                  } on PlatformException catch (e) {
                                    print("Failed to pick image: $e");
                                  }
                                  Navigator.pop(context);
                                }),
                            ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text(
                                    "Escolha uma foto da biblioteca"),
                                onTap: () async {
                                  try {
                                    final image = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (image == null) return;
                                    final imageTemporary = File(image.path);
                                    setState(() {
                                      this.image = imageTemporary;
                                    });
                                  } on PlatformException catch (e) {
                                    print("Failed to pick image: $e");
                                  }
                                  Navigator.pop(context);
                                }),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.add),
                label: const Text("Update")),
            image != null
                ? Image.file(
                    image!,
                    width: 320,
                    height: 320,
                    fit: BoxFit.cover,
                  )
                : const FlutterLogo(size: 320),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  image = null;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                if (image == null) return;
                try {
                  String ref =
                      "images/${widget.currentUserModel.sId}/profilepicture/profilepicture.jpg";
                  await FirebaseStorage.instance.ref(ref).putFile(image!);
                  final imageUrl = await FirebaseStorage.instance
                      .ref()
                      .child(ref)
                      .getDownloadURL();
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(widget.currentUserModel.sId)
                      .update(
                    {"profile_picture": imageUrl},
                  );
                  Navigator.pop(context);
                } on FirebaseException catch (e) {
                  throw Exception("Erro: $e");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
