import 'package:flutter/material.dart';

class MyPostPage extends StatelessWidget {
  final String id;
  final String url;
  final String description;

  const MyPostPage(
      {Key? key,
      required this.id,
      required this.url,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: true,
      right: true,
      minimum: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(url),
                ),
              ),
              width: 40,
              height: 40,
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}
