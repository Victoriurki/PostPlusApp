import 'package:flutter/material.dart';

class MyTextButtonWidget extends StatelessWidget {
  const MyTextButtonWidget(
      {Key? key, required this.action, required this.title})
      : super(key: key);

  final Function() action;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)
      ),
    );
  }
}
