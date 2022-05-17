import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../my_themes/my_app_theme.dart';
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Update Profile Picture",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 30),
                ),
                const SizedBox(
                  height: 16,
                ),
                image != null
                    ? Image.file(
                        image!,
                        width: 320,
                        height: 320,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageUrl: widget.currentUserModel.profilePicture!,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 320,
                          width: 320,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                blurRadius: 2,
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      onPrimary: MyAppTheme.greyColor,
                      primary: MyAppTheme.softBlueColor,
                    ),
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
                    icon: Icon(
                      Icons.add,
                      color: MyAppTheme.greyColor,
                    ),
                    label: const Text("Update")),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: MyAppTheme.greyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          image = null;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: MyAppTheme.greyColor,
                      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
