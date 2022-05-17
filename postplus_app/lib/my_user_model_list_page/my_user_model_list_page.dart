import 'package:flutter/material.dart';
import 'package:postplus_app/get_user_model_list/get_user_model_list.dart';
import 'package:postplus_app/my_widgets/my_user_card.dart';

import '../my_themes/my_app_theme.dart';
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
          body: FutureBuilder<List<UserModel>>(
            future: getUserModelList(userList),
            builder: (context, snapshot) {
              {
                //erro
                if (snapshot.hasError) {
                  const Text("Something went wrong");
                }
                //loading
                if (snapshot.connectionState == ConnectionState.waiting) {
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
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.connectionState == ConnectionState.done) {
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
                } else {
                  // sei la que deu
                  return CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
