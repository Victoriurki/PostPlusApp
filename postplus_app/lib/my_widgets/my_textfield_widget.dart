import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatefulWidget {
  const MyTextFieldWidget(
      {Key? key,
      required this.obscureText,
      required this.label,
      required this.hint,
      required this.onChanged,
      this.errorText = "",
      this.showErrorText = false,
      this.controller})
      : super(key: key);

  final String label;
  final String hint;
  final String errorText;
  final bool obscureText;
  final bool showErrorText;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText ? !_passwordVisible : widget.obscureText,
      onChanged: widget.onChanged,
      
      decoration: InputDecoration(
        errorText: widget.showErrorText ? widget.errorText : null,
        labelText: widget.label,
        hintText: widget.hint,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(
                    () {
                      _passwordVisible = !_passwordVisible;
                    },
                  );
                },
              )
            : null,
      ),
      controller: widget.controller,
    );
  }
}
