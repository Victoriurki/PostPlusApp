import 'package:flutter/material.dart';
import 'package:postplus_app/my_login_page/my_login_page.dart';
import 'package:postplus_app/my_themes/my_app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyAppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const MyLoginPage(),
    );
  }
}
