import 'package:flutter/material.dart';
import 'package:postplus_app/get_following_user_posts/get_following_user_posts.dart';
import 'package:postplus_app/my_themes/my_color_theme.dart';
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
      child: Scaffold(
        primary: true,
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(
          currentUserModel: widget.currentUserModel,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                MyColorTheme.backgroundGradientColorA,
                MyColorTheme.backgroundGradientColorB,
              ],
            ),
          ),
          child: FutureBuilder<List<PostModel>>(
            future: getFollowingUserPosts(widget.currentUserModel.followers!),
            builder: (context, snapshot) {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView.builder(
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
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                MyColorTheme.backgroundGradientColorA,
                                MyColorTheme.backgroundGradientColorB,
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
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    snapshot.data![index].ownerData!
                                        .profilePicture!,
                                  ),
                                ),
                                title: Text(
                                  "${snapshot.data![index].ownerData!.firstName!} ${snapshot.data![index].ownerData!.lastName!}",
                                ),
                              ),
                              Container(
                                height: 216,
                                width: 344,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      MyColorTheme.backgroundGradientColorA,
                                      MyColorTheme.backgroundGradientColorB,
                                    ],
                                  ),
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
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      snapshot.data![index].url!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
