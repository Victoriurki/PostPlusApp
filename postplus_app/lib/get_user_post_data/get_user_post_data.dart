import 'package:cloud_firestore/cloud_firestore.dart';
import '../post_model/post_model.dart';

Future<List<PostModel>> getUserPosts(String id) async {
  final postCollection = await FirebaseFirestore.instance
      .collection("users")
      .doc(id)
      .collection("postdata")
      .get();
  final posts =
      postCollection.docs.map((e) => PostModel.fromJson(e.data())).toList();
  if (posts.isEmpty) {
    return [];
  }
  return posts;
}
