import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import '../generics/app_error.dart';
import '../generics/result.dart';
import '../user_model/user_model.dart';

Future<Result<UserModel, AppError>> postMyRegister(UserModel user) async {
  var url = 'https://academy-auth.herokuapp.com/register';

  try {
    final response = await Dio().post(url, data: user.toJson());
    final parsedResponse = UserModel.fromJson(response.data);
    final userModel = parsedResponse;
    FirebaseFirestore.instance.collection("users").doc(userModel.sId).set(
      {
        "_id": userModel.sId,
        "email": userModel.email,
        "first_name": userModel.firstName,
        "last_name": userModel.lastName,
        "token": userModel.token,
        "username": user.username,
        "biography": "",
        "profile_picture":
            "https://scontent.fbfh3-3.fna.fbcdn.net/v/t1.18169-9/10401972_472787482918821_4958068379902033714_n.jpg?_nc_cat=100&ccb=1-6&_nc_sid=09cbfe&_nc_eui2=AeFnl0sjJ1Zde5ZGN7xtgP5dR-_BvQwHR7tH78G9DAdHu0G17qPMMRQMZec8NNt8GbGYgIc2uG1iS2WVdI_QC1yF&_nc_ohc=PjNjg4QP1D0AX8xqrxL&_nc_ht=scontent.fbfh3-3.fna&oh=00_AT-zvWpoFdWWLt3d4OA2URUDUiXrwppc4U1iPyBvYpF6Wg&oe=62A1207A",
        "followers": [],
        "following": [],
      },
    );
    return Result(data: userModel);
  } catch (e) {
    return Result(error: AppError.backend);
  }
}
