import 'package:flutter/material.dart';
import 'package:postplus_app/my_search_page/my_search_page.dart';
import '../my_profie_page/my_profile_page.dart';
import '../my_upload_image_page/my_upload_image_page.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  const MyAppBar({Key? key, required this.currentUserId}) : super(key: key);

  final String currentUserId;

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
      leading: IconButton(
          icon: const Icon(Icons.camera_alt, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    MyUploadImagePage(currentUserId: widget.currentUserId),
              ),
            );
          }),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MySearchPage(
                  currentUserId: widget.currentUserId,
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyProfilePage(
                  currentUserId: widget.currentUserId,
                  selectedUserId: widget.currentUserId,
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
