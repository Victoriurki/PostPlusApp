import 'package:flutter/material.dart';
import 'package:postplus_app/get_user_model_list/get_user_model_list.dart';
import 'package:postplus_app/my_widgets/my_user_card.dart';

import '../user_model/user_model.dart';

class MyUserModelListPage extends StatelessWidget {
  final String title;
  final List<UserModel> userList;
  final String currentUserId;

  const MyUserModelListPage(
      {Key? key,
      required this.title,
      required this.userList,
      required this.currentUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<UserModel>>(
          future: getUserModelList([]),
          builder: (context, snapshot) {
            return Column(
            children: [
              Text(title),
              ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return MyUserCard(
                      currentUserId: currentUserId,
                      selectedUserModel: userList[index]);
                },
              ),
            ],
            ); 
          },
        ),
      ),
    );
  }
}
