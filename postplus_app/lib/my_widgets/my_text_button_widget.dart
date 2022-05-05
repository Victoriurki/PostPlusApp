import 'package:flutter/material.dart';

class MyTextButtonWidget extends StatelessWidget {
  const MyTextButtonWidget({Key? key, required this.action, required this.title}) : super(key: key);

  final Function() action;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(title),
      onPressed: action,
    );
  }
}
