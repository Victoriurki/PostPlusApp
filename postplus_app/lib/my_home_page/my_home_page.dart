import 'package:flutter/material.dart';
import 'package:postplus_app/get_user_post_data/get_user_post_data.dart';
import 'package:postplus_app/my_themes/my_color_theme.dart';
import 'package:postplus_app/post_model/post_model.dart';
import '../my_app_bar/my_app_bar.dart';
import '../user_model/user_model.dart';

class MyHomePage extends StatefulWidget {
  final UserModel currentUserModel;

  const MyHomePage({Key? key, required this.currentUserModel}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: true,
      right: true,
      minimum: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: Scaffold(
        primary: true,
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(
          currentUserModel: widget.currentUserModel,
        ),
        body: Column(
          
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<List<PostModel>> (
              future: getUserPosts(widget.currentUserId),
              builder: (context, snapshot) {
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
                                  backgroundImage: NetworkImage(snapshot.data![index].url!,
                                  ),
                                ),
                                title: Text("snapshot.data!.first_name + last_name"),
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
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'images/652483.jpg',
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
