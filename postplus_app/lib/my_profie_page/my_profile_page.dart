import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/user_model/user_model.dart';
import '../get_current_user_info/get_current_user_info.dart';

class MyProfilePage extends StatefulWidget {
  final String currentUserId;
  final String selectedUserId;

  const MyProfilePage(
      {Key? key, required this.currentUserId, required this.selectedUserId})
      : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late Future<List<String>> getPostUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  const Text("Something went wrong");
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

                /// carregando
                // if (snapshot.data!.email!.isEmpty && !snapshot.hasError) {
                //   return Text(
                //     "Erro123",
                //     style: Theme.of(context).textTheme.headlineMedium,
                //   );
                // }

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
                          Column(
                            children: [
                              Text("${snapshot.data!.followers!.length}"),
                              const Text("followers")
                            ],
                          ),
                          ClipOval(
                            child: Image.network(
                              snapshot.data!.profilePicture!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: [
                              Text("${snapshot.data!.following!.length}"),
                              const Text("following")
                            ],
                          ),
                        ],
                      ),
                      widget.selectedUserId == widget.currentUserId
                          ? Column(children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Edit image")),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Edit profile")),
                            ])
                          : FutureBuilder<UserModel>(
                              future: getCurrentUserModel(widget.currentUserId),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  const Text("Something went wrong");
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
                                  return const Text("error");
                                }
                                if (snapshot.hasData &&
                                    !snapshot.hasError &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  if (snapshot.data!.following!
                                      .toString()
                                      .contains(widget.selectedUserId)) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(widget.currentUserId)
                                            .update(
                                          {
                                            "following": FieldValue.arrayRemove(
                                              [widget.selectedUserId],
                                            )
                                          },
                                        );
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(widget.selectedUserId)
                                            .update(
                                          {
                                            "followers": FieldValue.arrayRemove(
                                              [widget.currentUserId],
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
                                              .doc(widget.currentUserId)
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
                                                [widget.currentUserId],
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
                      GridView.builder(
                        itemCount: snapshot.data!.pictures!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return Image.network(
                            snapshot.data!.pictures![index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  // sei la quye que deu
                  return CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
