import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? firstName;
  final String? lastName;
  final String? id;
  final String? profilePicture;
  final String? username;

  DataModel({this.username, this.firstName, this.lastName, this.id, this.profilePicture});

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;
      return DataModel(
          firstName: dataMap['first_name'],
          lastName: dataMap['last_name'],
          id: dataMap['_id'],
          profilePicture: dataMap['profile_picture'],
          username: dataMap['username'],
          );
    }).toList();
  }
}
