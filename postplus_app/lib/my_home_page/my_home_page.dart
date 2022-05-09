import 'package:flutter/material.dart';

import '../my_upload_image_page/my_upload_image_page.dart';

class MyHomePage extends StatefulWidget {

  final String currentUserId;

  const MyHomePage({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyUploadImagePage(currentUserId: widget.currentUserId),
                  ));
            },
            icon: const Icon(Icons.add),
            label: const Text("Photo")),
      ),
    );
  }
}
