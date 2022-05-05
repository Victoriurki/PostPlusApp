import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatefulWidget {
  const MyTextFieldWidget({Key? key, this.obscureText = false})
      : super(key: key);

  final bool obscureText;

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
    );
  }
}