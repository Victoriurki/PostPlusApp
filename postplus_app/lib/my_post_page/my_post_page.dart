import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/post_model/post_model.dart';
import 'package:postplus_app/user_model/user_model.dart';
import '../get_selected_post_data/get_selected_post_data.dart';

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
      child: Scaffold(
        body: Center(
          child: FutureBuilder<PostModel>(
              future: getCurrentPostModel(widget.postId, widget.selectedUserId),
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(snapshot.data!.url!),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.width*0.50625,
                    ),
                    const SizedBox(height: 8),
                    Text(snapshot.data!.description!),
                    if (!snapshot.data!.likes!
                        .toString()
                        .contains(widget.currentUserModel.sId!)) ...[
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
                        icon: const Icon(Icons.favorite_outline_outlined),
                      )
                    ] else ...[
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
                        icon: const Icon(Icons.favorite),
                      )
                    ]
                  ],
                );
              }),
        ),
      ),
    );
  }
}
