import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postplus_app/user_model/user_model.dart';

Future<UserModel> getCurrentUserModel(String id) async {
  final document =
      await FirebaseFirestore.instance.collection("users").doc(id).get();
  final currentUserModel = UserModel(
    email: document.data()!["email"],
    firstName: document.data()!["first_name"],
    lastName: document.data()!["last_name"],
    sId: document.data()!["id"],
    token: document.data()!["token"],
    followers: document.data()!["followers"],
    following: document.data()!["following"],
    pictures: document.data()!["pictures"],
    profilePicture: document.data()!["profile_picture"]
  );
  return currentUserModel;
}
