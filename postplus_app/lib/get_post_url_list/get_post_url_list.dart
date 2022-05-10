import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getPostUrlList(String id) async {
  final document = await FirebaseFirestore.instance.collection("users").doc(id).get();
  final urlPostList = document.data()!["pictures"];
  return urlPostList;
}