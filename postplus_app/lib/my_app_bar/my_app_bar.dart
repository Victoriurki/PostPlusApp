import 'package:flutter/material.dart';
import 'package:postplus_app/my_search_page/my_search_page.dart';
import 'package:postplus_app/my_themes/my_app_theme.dart';
import '../my_profie_page/my_profile_page.dart';
import '../my_upload_image_page/my_upload_image_page.dart';
import '../user_model/user_model.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  const MyAppBar({Key? key, required this.currentUserModel}) : super(key: key);

  final UserModel currentUserModel;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: IconButton(
          icon: Icon(Icons.camera_alt, color: MyAppTheme.greyColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyUploadImagePage(
                  currentUserModel: widget.currentUserModel,
                ),
              ),
            ).then((value) {
              setState(() {});
            });
          }),
      actions: [
        ClipOval(
          child: IconButton(
            icon: Icon(
              Icons.search_outlined,
              color: MyAppTheme.greyColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MySearchPage(
                    currentUserModel: widget.currentUserModel,
                  ),
                ),
              ).then((value) {
                setState(() {});
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.person,
            color: MyAppTheme.greyColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyProfilePage(
                  currentUserModel: widget.currentUserModel,
                  selectedUserId: widget.currentUserModel.sId!,
                ),
              ),
            );
          },
        ),
      ],
      title: const Text(""),
    );
  }
}
