import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:postplus_app/generics/app_error.dart';
import '../generics/result.dart';
import '../user_model/user_model.dart';

Future<Result<UserModel, AppError>> postMyLogin(UserModel user) async {
  var url = 'https://academy-auth.herokuapp.com/login';

  try {
    final response = await Dio().post(url, data: user.toJson());
    final parsedResponse = UserModel.fromJson(response.data);
    final userModel = parsedResponse;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.sId)
        .update(
      {
        "_id": userModel.sId,
        "email": userModel.email,
        "first_name": userModel.firstName,
        "last_name": userModel.lastName,
        "token": userModel.token, //this updates the token in firebase
      },
    );

    final document = await FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.sId)
        .get();

    UserModel finalUserModel = UserModel.fromJson(document.data()!);

    return Result(data: finalUserModel);
  } catch (e) {
    return Result(error: AppError.backend);
  }
}
