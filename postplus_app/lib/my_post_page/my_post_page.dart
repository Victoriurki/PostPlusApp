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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(url),
                  ),
                ),
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 8),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}
