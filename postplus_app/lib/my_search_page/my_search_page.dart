import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:postplus_app/my_profie_page/my_profile_page.dart';
import '../data_model/data_model.dart';

class MySearchPage extends StatefulWidget {
  final String currentUserId;

  const MySearchPage({Key? key, required this.currentUserId}) : super(key: key);

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
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyProfilePage(
                              currentUserId: widget.currentUserId,
                              selectedUserId: data.id!),
                        ),
                      );
                    },
                    title: Text("${(data.firstName)} ${(data.lastName)}"),
                    subtitle: Text('@${data.username}'),
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data.profilePicture!),
                        ),
                      ),
                      width: 40,
                      height: 40,
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
