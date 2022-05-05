import 'package:dio/dio.dart';
import 'package:postplus_app/my_register_page/my_register_page.dart';

import '../user_model/user_model.dart';

Future<UserModel> postMyRegister(UserModel user) async {
  var url = 'https://academy-auth.herokuapp.com/register';
  final response = await Dio().post(url, data: user.toJson());
  if (response.statusCode != 201) {
    return UserModel();
  }
  final parsedResponse = UserModel.fromJson(response.data);
  final userModel = parsedResponse;
  print(userModel.sId);
  return userModel;
  
}
