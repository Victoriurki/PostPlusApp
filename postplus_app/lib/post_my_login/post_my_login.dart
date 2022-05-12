import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import '../user_model/user_model.dart';

Future<UserModel> postMyLogin(UserModel user) async {
  var url = 'https://academy-auth.herokuapp.com/login';
  final response = await Dio().post(url, data: user.toJson());
  if (response.statusCode != 201) {
    return UserModel();
  }
  final parsedResponse = UserModel.fromJson(response.data);
  final userModel = parsedResponse;

  await FirebaseFirestore.instance.collection("users").doc(userModel.sId).update(
    {
      "id": userModel.sId,
      "email": userModel.email,
      "first_name": userModel.firstName,
      "last_name": userModel.lastName,
      "token": userModel.token, //this updates the token in firebase
    },
  );
  return userModel;
}
