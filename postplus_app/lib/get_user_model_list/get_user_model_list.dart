import 'package:postplus_app/get_current_user_info/get_current_user_info.dart';
import '../user_model/user_model.dart';

Future<List<UserModel>> getUserModelList(List<dynamic> userIdList) async {
  List<UserModel> userModelList = [];

  for (String userId in userIdList) {
    UserModel currentUserModel = await getCurrentUserModel(userId);
    userModelList.add(currentUserModel);
  }

  return userModelList;
}
