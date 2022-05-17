import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/my_edit_profile_page/my_edit_profile_page.dart';
import 'package:postplus_app/my_post_page/my_post_page.dart';
import 'package:postplus_app/my_themes/my_app_theme.dart';
import 'package:postplus_app/my_update_profile_picture_page/my_update_profile_picture_page.dart';
import 'package:postplus_app/my_user_model_list_page/my_user_model_list_page.dart';
import 'package:postplus_app/user_model/user_model.dart';
import '../get_current_user_info/get_current_user_info.dart';
import '../get_user_post_data/get_user_post_data.dart';
import '../my_themes/my_app_theme.dart';
import '../post_model/post_model.dart';

class MyProfilePage extends StatefulWidget {
  final UserModel currentUserModel;
  final String selectedUserId;

  const MyProfilePage(
      {Key? key, required this.currentUserModel, required this.selectedUserId})
      : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late Future<List<String>> getPostUrl;

  @override
  Widget build(BuildContext context) {

    return Container(
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
          padding: const EdgeInsets.all(8.0),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              FutureBuilder<UserModel>(
                future: getCurrentUserModel(widget.selectedUserId),
                builder: (context, snapshot) {
                  /// deu ruim
                  if (snapshot.hasError) {
                    const Text("Something went wrong 1");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Text("error");
                  }

                  /// caminho feliz
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MyUserModelListPage(
                                        title: "Followers",
                                        userList: snapshot.data!.followers!,
                                        currentUserModel:
                                            widget.currentUserModel),
                                  ),
                                );
                              },
                              child: Column(
                                children: [


                                  Text(
                                    "${snapshot.data!.followers!.length}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    "followers",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: MyAppTheme.softGreyColor),
                                  )

                                ],
                              ),
                            ),
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.profilePicture!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MyUserModelListPage(
                                        title: "Following",
                                        userList: snapshot.data!.following!,
                                        currentUserModel:
                                            widget.currentUserModel),
                                  ),
                                );
                              },
                              child: Column(
                                children: [

                                  Text(
                                    "${snapshot.data!.following!.length}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    "following",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: MyAppTheme.softGreyColor),
                                  )

                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(

                          "${snapshot.data!.firstName!} ${snapshot.data!.lastName!}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "@${snapshot.data!.username}",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: MyAppTheme.softGreyColor),
                        ),
                        widget.selectedUserId == widget.currentUserModel.sId
                            ? Column(children: [
                                TextButton(

                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MyEditProfilePage(
                                            currentUserModel: snapshot.data!),
                                      ),
                                    ).then((value) {
                                      setState(() {});
                                    });
                                  },

                                  child: Text(
                                    "Edit image",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: MyAppTheme.greyColor,
                                    primary: MyAppTheme.softBlueColor,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MyEditProfilePage(
                                            currentUserModel: snapshot.data!),
                                      ),
                                    ).then((value) {
                                      setState(() {});
                                    });
                                  },

                                  child: const Text("Edit profile"),
                                ),
                              ])
                            : FutureBuilder<UserModel>(
                                future: getCurrentUserModel(
                                    widget.currentUserModel.sId!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    const Text("Something went wrong 2");
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    );
                                  }
                                  if (!snapshot.hasData) {
                                    return const Text("error 2");
                                  }
                                  if (snapshot.hasData &&
                                      !snapshot.hasError &&
                                      snapshot.connectionState ==
                                          ConnectionState.done) {
                                    if (snapshot.data!.following
                                        .toString()
                                        .contains(widget.selectedUserId)) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(widget.currentUserModel.sId)
                                              .update(
                                            {

                                              "following":
                                                  FieldValue.arrayRemove(

                                                [widget.selectedUserId],
                                              )
                                            },
                                          );
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(widget.selectedUserId)
                                              .update(
                                            {

                                              "followers":
                                                  FieldValue.arrayRemove(

                                                [widget.currentUserModel.sId],
                                              )
                                            },
                                          );
                                          setState(() {});
                                        },
                                        child: const Text("Following"),
                                      );
                                    } else {
                                      return ElevatedButton(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("users")

                                                .doc(widget
                                                    .currentUserModel.sId!)

                                                .update(
                                              {
                                                "following":
                                                    FieldValue.arrayUnion(
                                                  [widget.selectedUserId],
                                                )
                                              },
                                            );
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(widget.selectedUserId)
                                                .update(
                                              {
                                                "followers":
                                                    FieldValue.arrayUnion(
                                                  [widget.currentUserModel.sId],
                                                )
                                              },
                                            );
                                            setState(() {});
                                          },
                                          child: const Text("Follow"));
                                    }
                                  } else {
                                    // sei la quye que deu
                                    return CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    );
                                  }
                                },
                              ),
                      ],
                    );
                  } else {
                    // sei la o que deu
                    return CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    );
                  }
                },
              ),
              FutureBuilder<List<PostModel>>(
                future: getUserPosts(widget.selectedUserId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    const Text("Something went wrong 3");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Text("Something went wrong 4");
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Text("This user didn't post yet D:");
                  }
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                        itemCount: snapshot.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MyPostPage(
                                      currentUserModel: widget.currentUserModel,
                                      selectedUserId: widget.selectedUserId,
                                      postId: snapshot.data![index].id!),
                                ),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data![index].url!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          );
                        });
                  } else {
                    // sei la o que deu
                    return CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
