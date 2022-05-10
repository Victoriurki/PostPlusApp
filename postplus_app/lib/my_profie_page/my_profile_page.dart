import 'package:flutter/material.dart';

import '../get_post_url_list/get_post_url_list.dart';

class MyProfilePage extends StatelessWidget {
  final String currentId;

  const MyProfilePage({Key? key, required this.currentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [Text("1287"), Text("followers")],
              ),
              ClipOval(
                child: Container(
                  color: Colors.black,
                  height: 100,
                  width: 100,
                ),
              ),
              Column(
                children: [Text("1106"), Text("following")],
              ),
            ],
          ),
          FutureBuilder<List<String>>(
            future: getPostUrlList(currentId),
            builder: (context, snapshot) {
              return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Image.network(snapshot.data![index]),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
