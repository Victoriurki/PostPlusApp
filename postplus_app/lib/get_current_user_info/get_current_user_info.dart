import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postplus_app/user_model/user_model.dart';

Future<UserModel> getCurrentUserModel(String id) async {
  final document =
      await FirebaseFirestore.instance.collection("users").doc(id).get();
  final currentUserModel = UserModel.fromJson(document.data()!);
  return currentUserModel;
}
