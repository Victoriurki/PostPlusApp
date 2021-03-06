import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:postplus_app/my_themes/my_app_theme.dart';
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
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Add Photo",
                    style: Theme.of(context).textTheme.titleLarge,
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
                          imageUrl:
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Picture_icon_BLACK.svg/1200px-Picture_icon_BLACK.svg.png",
                          imageBuilder: (context, imageProvider) => Container(
                            height: 320,
                            width: 320,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                            final imageTemporary =
                                                File(image.path);
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
                                            final imageTemporary =
                                                File(image.path);
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
                        label: Text(
                          "Add",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            image = null;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  MyTextFieldWidget(
                      maxLength: 300,
                      obscureText: false,
                      label: "Description",
                      hint: "Type your description here!",
                      onChanged: (text) {
                        description = text;
                      }),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      onPrimary: MyAppTheme.greyColor,
                      primary: MyAppTheme.softBlueColor,
                    ),
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
                    icon: const Icon(Icons.check),
                    label: Text(
                      "Post Photo",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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
