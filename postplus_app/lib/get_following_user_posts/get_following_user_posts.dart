import 'package:cloud_firestore/cloud_firestore.dart';
import '../post_model/post_model.dart';

Future<List<PostModel>> getFollowingUserPosts(
    List<dynamic> followingList, ) async {
  List<PostModel> followingFullPostList = [];
  for (int i = 0; i < followingList.length; i++) {
    final QuerySnapshot<Map<String, dynamic>> postCollection =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(followingList[i])
            .collection("postdata")
            .get();
    final posts =
        postCollection.docs.map((e) => PostModel.fromJson(e.data())).toList();
    if (posts.isEmpty) {
    } else {
      followingFullPostList.addAll(posts);
    }
  }
  if (followingFullPostList.isEmpty) {
    return [];
  }

  followingFullPostList.sort(((a, b) => b.id!.compareTo(a.id!)));
  print(followingFullPostList);
  return followingFullPostList;
}
