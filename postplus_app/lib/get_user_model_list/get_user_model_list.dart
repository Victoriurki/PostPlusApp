import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postplus_app/get_current_user_info/get_current_user_info.dart';
import '../user_model/user_model.dart';

Future<List<UserModel>> getUserModelList(List<String> userIdList) async {
  return [];
  // List<UserModel> userModelList = userIdList.forEach((e) {getCurrentUserModel(e).}.);

  // final postCollection = await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc(userIdList[index])
  //     .collection("postdata")
  //     .get();
  // final posts =
  //     postCollection.docs.map((e) => PostModel.fromJson(e.data())).toList();
  // if (posts.isEmpty) {
  //   return [];
  // }
  // return posts;
}
