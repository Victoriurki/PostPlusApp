import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/my_user_model_list_page/my_user_model_list_page.dart';
import 'package:postplus_app/post_model/post_model.dart';
import 'package:postplus_app/user_model/user_model.dart';
import '../get_selected_post_data/get_selected_post_data.dart';
import '../my_themes/my_app_theme.dart';

class MyPostPage extends StatefulWidget {
  final String postId;
  final String selectedUserId;
  final UserModel currentUserModel;

  const MyPostPage({
    Key? key,
    required this.currentUserModel,
    required this.selectedUserId,
    required this.postId,
  }) : super(key: key);

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
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
            child: FutureBuilder<PostModel>(
                future: getCurrentPostModel(widget.postId, widget.selectedUserId),
                builder: (context, snapshot) {
                  {
                    //erro
                    if (snapshot.hasError) {
                      const Text("Something went wrong");
                    }
                    //loading
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                    //não tem data
                    if (!snapshot.hasData) {
                      return const Text("No data");
                    }
                    //caminho feliz
                    if (snapshot.hasData &&
                        !snapshot.hasError &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    snapshot.data!.url!),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.width * 0.50625,
                          ),
                          const SizedBox(height: 8),
                          Text(snapshot.data!.description!),
                          if (!snapshot.data!.likes!
                              .toString()
                              .contains(widget.currentUserModel.sId!)) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(widget.selectedUserId)
                                        .collection("postdata")
                                        .doc(snapshot.data!.id)
                                        .update({
                                      "likes": FieldValue.arrayUnion(
                                        [widget.currentUserModel.sId],
                                      )
                                    });
                                    setState(() {});
                                  },
                                  icon:
                                      const Icon(Icons.favorite_outline_outlined),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyUserModelListPage(
                                            title: "Likes",
                                            userList: snapshot.data!.likes!,
                                            currentUserModel:
                                                widget.currentUserModel),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      "${snapshot.data!.likes!.length.toString()} likes"),
                                ),
                              ],
                            )
                          ] else ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(widget.selectedUserId)
                                        .collection("postdata")
                                        .doc(snapshot.data!.id)
                                        .update({
                                      "likes": FieldValue.arrayRemove(
                                        [widget.currentUserModel.sId],
                                      )
                                    });
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.favorite), color: Colors.red,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyUserModelListPage(
                                            title: "Likes",
                                            userList: snapshot.data!.likes!,
                                            currentUserModel:
                                                widget.currentUserModel),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      "${snapshot.data!.likes!.length.toString()} likes"),
                                ),
                              ],
                            )
                          ]
                        ],
                      );
                    } else {
                      // sei la que deu
                      return CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      );
                    }
                  }
                }),
          ),
        ),
      ),
    );
  }
}
