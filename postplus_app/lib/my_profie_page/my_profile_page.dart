import 'package:flutter/material.dart';

import '../get_post_url_list/get_post_url_list.dart';

class MyProfilePage extends StatefulWidget {
  final String currentUserId;

  const MyProfilePage({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late Future<List<String>> getPostUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
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
              initialData: [],
              future: getPostUrlList(widget.currentUserId),
              builder: (context, snapshot) {
                /// deu ruim
                if (snapshot.hasError) {
                  const Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Text("error");
                }
                /// carregando
                if (snapshot.data!.isEmpty && !snapshot.hasError) {
                  return Text(
                    "Você ainda não tem fotos",
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                /// caminho feliz
                if (snapshot.hasData && !snapshot.hasError) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          snapshot.data![index],
                        );
                      });
                } else {
                  // sei la quye que deu
                  return CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
