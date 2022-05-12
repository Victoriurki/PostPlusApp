import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/my_widgets/my_user_card.dart';
import 'package:postplus_app/user_model/user_model.dart';
import '../data_model/data_model.dart';

class MySearchPage extends StatefulWidget {
  final UserModel currentUserModel;

  const MySearchPage({Key? key, required this.currentUserModel}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  String text = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: true,
      right: true,
      minimum: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: FirestoreSearchScaffold(
        firestoreCollectionName: 'users',
        searchBy: 'username',
        scaffoldBody: const Center(),
        dataListFromSnapshot: DataModel().dataListFromSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DataModel>? dataList = snapshot.data;
            if (dataList!.isEmpty) {
              return const Center(
                child: Text('No Results Returned'),
              );
            }
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final DataModel data = dataList[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MyUserCard(
                    currentUserModel: widget.currentUserModel,
                    selectedUserModel: UserModel(
                      username: data.username,
                      firstName: data.firstName,
                      lastName: data.lastName,
                      sId: data.id,
                      profilePicture: data.profilePicture,
                    ),
                  ),
                );
              },
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Results Returned'),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
