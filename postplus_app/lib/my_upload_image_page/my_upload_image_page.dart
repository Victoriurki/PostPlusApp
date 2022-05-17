import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:postplus_app/my_widgets/my_textfield_widget.dart';

import '../user_model/user_model.dart';

class MyUploadImagePage extends StatefulWidget {
  final UserModel currentUserModel;
  const MyUploadImagePage({Key? key, required this.currentUserModel})
      : super(key: key);

  @override
  State<MyUploadImagePage> createState() => _MyUploadImagePageState();
}

class _MyUploadImagePageState extends State<MyUploadImagePage> {
  String description = '';
  File? image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
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
                                            .pickImage(
                                                source: ImageSource.camera);
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
                                            .pickImage(
                                                source: ImageSource.gallery);
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
                    label: const Text("Photo")),
                image != null
                    ? Image.file(
                        image!,
                        width: 320,
                        height: 320,
                        fit: BoxFit.cover,
                      )
                    : Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Picture_icon_BLACK.svg/1200px-Picture_icon_BLACK.svg.png"),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      image = null;
                    });
                  },
                ),
                MyTextFieldWidget(
                    maxLength: 300,
                    obscureText: false,
                    label: "Description",
                    hint: "Type your description here!",
                    onChanged: (text) {
                      description = text;
                    }),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    if (image == null) return;
                    try {
                      String ref =
                          "images/${widget.currentUserModel.sId}/${DateTime.now().toString()}.jpg";
                      await FirebaseStorage.instance.ref(ref).putFile(image!);
                      final datetime = DateTime.now().toString();
                      final imageUrl = await FirebaseStorage.instance
                          .ref()
                          .child(ref)
                          .getDownloadURL();
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.currentUserModel.sId)
                          .collection("postdata")
                          .doc(datetime)
                          .set(
                        {
                          "url": imageUrl,
                          "_id": datetime,
                          "description": description,
                          "likes": [],
                          "owner_id": widget.currentUserModel.sId
                        },
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
        ),
      ),
    );
  }
}
