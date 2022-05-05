import 'package:flutter/material.dart';

class MyElevatedButtonWidget extends StatelessWidget {
  const MyElevatedButtonWidget(
      {Key? key, required this.action, required this.title})
      : super(key: key);
  final Function() action;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      child: Text(title),
      style: ElevatedButton.styleFrom(
          primary: Colors.pink,
          textStyle: const TextStyle(
            color: Colors.white,
          )),
    );
  }
}
