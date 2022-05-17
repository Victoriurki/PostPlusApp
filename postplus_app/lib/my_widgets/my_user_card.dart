import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../my_profie_page/my_profile_page.dart';
import '../user_model/user_model.dart';

class MyUserCard extends StatelessWidget {
  final UserModel selectedUserModel;
  final UserModel currentUserModel;

  const MyUserCard({
    Key? key,
    required this.currentUserModel,
    required this.selectedUserModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MyProfilePage(
              currentUserModel: currentUserModel,
              selectedUserId: selectedUserModel.sId!,
            ),
          ),
        );
      },
      title: Text(
          "${(selectedUserModel.firstName)} ${(selectedUserModel.lastName)}"),
      subtitle: Text('@${selectedUserModel.username}'),
      leading: CachedNetworkImage(
        imageUrl: selectedUserModel.profilePicture!,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        imageBuilder: (context, imageProvider) => Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
