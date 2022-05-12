import 'package:cloud_firestore/cloud_firestore.dart';
import '../post_model/post_model.dart';

Future<PostModel> getCurrentPostModel(String postId, String selectedUserId) async {
  final document =
      await FirebaseFirestore.instance.collection("users").doc(selectedUserId).collection("postdata").doc(postId).get();
  final currentPostModel = PostModel.fromJson(document.data()!);
  return currentPostModel;
}