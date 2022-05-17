import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:postplus_app/generics/app_error.dart';
import '../generics/result.dart';
import '../user_model/user_model.dart';

Future<Result<UserModel, AppError>> updatePassword(
  UserModel currentUser,
  String newPassword,
) async {
  var url = 'https://academy-auth.herokuapp.com/update';

  try {
    await Dio().patch(
      url,
      data: {
        "email": currentUser.email,
        "new_password": newPassword,
      },
      options: Options(
        headers: {
          "x-access-token": currentUser.token,
        },
      ),
    );
    final document = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.sId)
        .get();
    UserModel finalUserModel = UserModel.fromJson(document.data()!);

    return Result(data: finalUserModel);
  } catch (e) {
    return Result(error: AppError.backend);
  }
}
