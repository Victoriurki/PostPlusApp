import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/get_current_user_info/get_current_user_info.dart';
import 'package:postplus_app/get_following_user_posts/get_following_user_posts.dart';
import 'package:postplus_app/my_post_page/my_post_page.dart';
import 'package:postplus_app/my_profie_page/my_profile_page.dart';
import 'package:postplus_app/my_themes/my_app_theme.dart';
import 'package:postplus_app/post_model/post_model.dart';
import '../my_app_bar/my_app_bar.dart';
import '../user_model/user_model.dart';

class MyHomePage extends StatefulWidget {
  final UserModel currentUserModel;

  const MyHomePage({Key? key, required this.currentUserModel})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          primary: true,
          extendBodyBehindAppBar: true,
          appBar: MyAppBar(
            currentUserModel: widget.currentUserModel,
          ),
          body: FutureBuilder<UserModel>(
              future: getCurrentUserModel(widget.currentUserModel.sId!),
              builder: (context, currentUserSnapshot) {
                {
                  //erro
                  if (currentUserSnapshot.hasError) {
                    const Text("Something went wrong");
                  }
                  //loading
                  if (currentUserSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                  //não tem data
                  if (!currentUserSnapshot.hasData) {
                    return const Text("No data");
                  }
                  //caminho feliz
                  if (currentUserSnapshot.hasData &&
                      !currentUserSnapshot.hasError &&
                      currentUserSnapshot.connectionState ==
                          ConnectionState.done) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: FutureBuilder<List<PostModel>>(
                        future: getFollowingUserPosts(
                            currentUserSnapshot.data!.following!,
                            widget.currentUserModel.sId!),
                        builder: (context, snapshot) {
                          //erro
                          if (snapshot.hasError) {
                            const Text("Something went wrong");
                          }
                          //loading
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                          if (snapshot.data!.isNotEmpty) {
                            if (snapshot.hasData &&
                                !snapshot.hasError &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 2,
                                                blurStyle: BlurStyle.outer,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              colors: [
                                                MyAppTheme
                                                    .backgroundGradientColorA,
                                                MyAppTheme
                                                    .backgroundGradientColorB,
                                              ],
                                            ),
                                          ),
                                          height: 288,
                                          width: 360,
                                          margin: const EdgeInsets.only(
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                FutureBuilder<UserModel>(
                                                  future: getCurrentUserModel(
                                                      snapshot.data![index]
                                                          .ownerId!),
                                                  builder: (context, postInfo) {
                                                    {
                                                      //erro
                                                      if (postInfo.hasError) {
                                                        const Text(
                                                            "Something went wrong");
                                                      }
                                                      //loading
                                                      if (postInfo
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        );
                                                      }
                                                      //não tem data
                                                      if (!postInfo.hasData) {
                                                        return const Text(
                                                            "No data");
                                                      }
                                                      //caminho feliz
                                                      if (postInfo.hasData &&
                                                          !postInfo.hasError &&
                                                          postInfo.connectionState ==
                                                              ConnectionState
                                                                  .done) {
                                                        return ListTile(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (_) => MyProfilePage(
                                                                    currentUserModel:
                                                                        widget
                                                                            .currentUserModel,
                                                                    selectedUserId: snapshot
                                                                        .data![
                                                                            index]
                                                                        .ownerId!),
                                                              ),
                                                            );
                                                          },
                                                          leading: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: postInfo
                                                                  .data!
                                                                  .profilePicture!,
                                                              progressIndicatorBuilder: (context,
                                                                      url,
                                                                      downloadProgress) =>
                                                                  CircularProgressIndicator(
                                                                      value: downloadProgress
                                                                          .progress),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                width: 40.0,
                                                                height: 40.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          title: Text(
                                                            "${postInfo.data!.firstName} ${postInfo.data!.lastName!}",
                                                          ),
                                                        );
                                                      } else {
                                                        // sei la que deu
                                                        return CircularProgressIndicator(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        );
                                                      }
                                                    }
                                                  },
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) => MyPostPage(
                                                            currentUserModel: widget
                                                                .currentUserModel,
                                                            selectedUserId:
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .ownerId!,
                                                            postId: snapshot
                                                                .data![index]
                                                                .id!),
                                                      ),
                                                    );
                                                  },
                                                  child: CachedNetworkImage(
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                    imageUrl: snapshot
                                                        .data![index].url!,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: 216,
                                                      width: 344,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .bottomLeft,
                                                          end: Alignment
                                                              .topRight,
                                                          colors: [
                                                            MyAppTheme
                                                                .backgroundGradientColorA,
                                                            MyAppTheme
                                                                .backgroundGradientColorB,
                                                          ],
                                                        ),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset:
                                                                Offset(2, 2),
                                                            blurRadius: 2,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              // sei la que deu
                              return CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              );
                            }
                          } else {
                            return Center(
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.refresh)),
                            );
                          }
                        },
                      ),
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
    );
  }
}
