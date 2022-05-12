import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/post_model/post_model.dart';

import '../get_selected_post_data/get_selected_post_data.dart';

class MyPostPage extends StatefulWidget {
  final String postId;
  final String selectedUserId;
  final String currentUserId;

  const MyPostPage({
    Key? key,
    required this.currentUserId,
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
      left: true,
      top: true,
      right: true,
      minimum: const EdgeInsets.fromLTRB(8, 16, 8, 0),
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
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 8),
                    Text(snapshot.data!.description!),
                    if (!snapshot.data!.likes!
                        .toString()
                        .contains(widget.currentUserId)) ...[
                      IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(snapshot.data!.ownerData!.id!)
                              .collection("postdata")
                              .doc(snapshot.data!.id)
                              .update({
                            "likes": FieldValue.arrayUnion(
                              [widget.currentUserId],
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
                              .doc(snapshot.data!.ownerData!.id!)
                              .collection("postdata")
                              .doc(snapshot.data!.id)
                              .update({
                            "likes": FieldValue.arrayRemove(
                              [widget.currentUserId],
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
