import 'package:cloud_firestore/cloud_firestore.dart';
import '../post_model/post_model.dart';

Future<List<PostModel>> getFollowingUserPosts(
    List<dynamic> followingList, String currentUserId,) async {
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
    final QuerySnapshot<Map<String, dynamic>> currentUserPostCollection =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserId)
            .collection("postdata")
            .get();
    final currentUserPosts =
        currentUserPostCollection.docs.map((e) => PostModel.fromJson(e.data())).toList();
    if (currentUserPosts.isEmpty) {
    } else {
      followingFullPostList.addAll(currentUserPosts);
    }
  followingFullPostList.sort(((a, b) => b.id!.compareTo(a.id!)));
  if (followingFullPostList.isEmpty) {
    return [];
  }
  return followingFullPostList;
}
