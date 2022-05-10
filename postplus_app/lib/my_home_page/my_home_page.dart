import 'package:flutter/material.dart';
import 'package:postplus_app/my_themes/my_color_theme.dart';
import '../my_app_bar/my_app_bar.dart';

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
      primary: true,
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        currentUserId: widget.currentUserId,
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
