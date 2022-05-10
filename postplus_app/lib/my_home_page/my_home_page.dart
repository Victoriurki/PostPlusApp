import 'package:flutter/material.dart';
import 'package:postplus_app/my_themes/my_color_theme.dart';
import 'package:postplus_app/my_upload_image_page/my_upload_image_page.dart';

import '../my_profie_page/my_profile_page.dart';

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
      drawer: Drawer(
        child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => MyProfilePage(currentUserId: widget.currentUserId)));
            },
            icon: const Icon(Icons.person),
            label: const Text("My Profile")),
      ),
      primary: true,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      MyUploadImagePage(currentUserId: widget.currentUserId),
                ),
              );
            }),
        actions: const [
          Icon(
            Icons.chat,
            color: Colors.black,
          ),
          Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ],
        title: const Text(""),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  MyColorTheme.backgroundGradientColorA,
                  MyColorTheme.backgroundGradientColorB,
                ],
              ),
            ),
            height: 288,
            width: 360,
            margin: const EdgeInsets.only(
              right: 8,
              left: 8,
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/652483.jpg',
                    ),
                  ),
                  title: Text('Victor Iurkiewiecz'),
                ),
                Container(
                  height: 216,
                  width: 344,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        MyColorTheme.backgroundGradientColorA,
                        MyColorTheme.backgroundGradientColorB,
                      ],
                    ),
                    shape: BoxShape.rectangle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/652483.jpg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  MyColorTheme.backgroundGradientColorA,
                  MyColorTheme.backgroundGradientColorB,
                ],
              ),
            ),
            height: 288,
            width: 360,
            margin: const EdgeInsets.only(
              right: 8,
              left: 8,
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/652483.jpg',
                    ),
                  ),
                  title: Text('Victor Iurkiewiecz'),
                ),
                Container(
                  height: 216,
                  width: 344,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        MyColorTheme.backgroundGradientColorA,
                        MyColorTheme.backgroundGradientColorB,
                      ],
                    ),
                    shape: BoxShape.rectangle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/652483.jpg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  MyColorTheme.backgroundGradientColorA,
                  MyColorTheme.backgroundGradientColorB,
                ],
              ),
            ),
            height: 288,
            width: 360,
            margin: const EdgeInsets.only(
              right: 8,
              left: 8,
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/652483.jpg',
                    ),
                  ),
                  title: Text('Victor Iurkiewiecz'),
                ),
                Container(
                  height: 216,
                  width: 344,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        MyColorTheme.backgroundGradientColorA,
                        MyColorTheme.backgroundGradientColorB,
                      ],
                    ),
                    shape: BoxShape.rectangle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/652483.jpg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  MyColorTheme.backgroundGradientColorA,
                  MyColorTheme.backgroundGradientColorB,
                ],
              ),
            ),
            height: 288,
            width: 360,
            margin: const EdgeInsets.only(
              right: 8,
              left: 8,
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/652483.jpg',
                    ),
                  ),
                  title: Text('Victor Iurkiewiecz'),
                ),
                Container(
                  height: 216,
                  width: 344,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        MyColorTheme.backgroundGradientColorA,
                        MyColorTheme.backgroundGradientColorB,
                      ],
                    ),
                    shape: BoxShape.rectangle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/652483.jpg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  MyColorTheme.backgroundGradientColorA,
                  MyColorTheme.backgroundGradientColorB,
                ],
              ),
            ),
            height: 288,
            width: 360,
            margin: const EdgeInsets.only(
              right: 8,
              left: 8,
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/652483.jpg',
                    ),
                  ),
                  title: Text('Victor Iurkiewiecz'),
                ),
                Container(
                  height: 216,
                  width: 344,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/652483.jpg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  MyColorTheme.backgroundGradientColorA,
                  MyColorTheme.backgroundGradientColorB,
                ],
              ),
            ),
            height: 288,
            width: 360,
            margin: const EdgeInsets.only(
              right: 8,
              left: 8,
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/652483.jpg',
                    ),
                  ),
                  title: Text('Victor Iurkiewiecz'),
                ),
                Container(
                  height: 216,
                  width: 344,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/652483.jpg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
