import 'package:flutter/material.dart';
import 'package:postplus_app/get_user_model_list/get_user_model_list.dart';
import 'package:postplus_app/my_widgets/my_user_card.dart';

import '../user_model/user_model.dart';

class MyUserModelListPage extends StatelessWidget {
  final String title;
  final List<dynamic> userList;
  final UserModel currentUserModel;

  const MyUserModelListPage(
      {Key? key,
      required this.title,
      required this.userList,
      required this.currentUserModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<UserModel>>(
          future: getUserModelList(userList),
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return MyUserCard(
                      currentUserModel: currentUserModel,
                      selectedUserModel: snapshot.data![index],
                    );
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
