import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MyUploadImagePage extends StatefulWidget {
  final String currentUserId;
  const MyUploadImagePage({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  State<MyUploadImagePage> createState() => _MyUploadImagePageState();
}

class _MyUploadImagePageState extends State<MyUploadImagePage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
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
                label: const Text("Photo")),
            image != null
                ? Image.file(
                    image!,
                    width: 320,
                    height: 320,
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
                      "images/${widget.currentUserId}/img-${DateTime.now().toString()}.jpg";
                  await FirebaseStorage.instance.ref(ref).putFile(image!);
                  final imageUrl = await FirebaseStorage.instance
                      .ref()
                      .child(ref)
                      .getDownloadURL();
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(widget.currentUserId)
                      .update(
                    {
                      "pictures": FieldValue.arrayUnion([imageUrl]),
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
    );
  }
}
