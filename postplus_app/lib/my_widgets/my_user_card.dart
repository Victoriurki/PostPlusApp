import 'package:flutter/material.dart';
import '../my_profie_page/my_profile_page.dart';
import '../user_model/user_model.dart';

class MyUserCard extends StatelessWidget {
  final UserModel selectedUserModel;
  final UserModel currentUserModel;

  const MyUserCard(
      {Key? key,
      required this.currentUserModel,
      required this.selectedUserModel,})
      : super(key: key);

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
      title: Text("${(selectedUserModel.firstName)} ${(selectedUserModel.lastName)}"),
      subtitle: Text('${selectedUserModel.username}'),
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(selectedUserModel.profilePicture!),
          ),
        ),
        width: 40,
        height: 40,
      ),
    );
  }
}
