import 'package:flutter/material.dart';
import 'package:postplus_app/my_app.dart';
import 'package:postplus_app/my_themes/my_app_theme.dart';

class MyElevatedButtonWidget extends StatelessWidget {
  const MyElevatedButtonWidget(
      {Key? key, required this.action, required this.title})
      : super(key: key);
  final Function()? action;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      child: Text(title),
      style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.titleMedium,
          primary: MyAppTheme.softBlueColor,
          onPrimary: MyAppTheme.greyColor),
    );
  }
}
