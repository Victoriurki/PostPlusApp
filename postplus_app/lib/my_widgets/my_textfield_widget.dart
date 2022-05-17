import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postplus_app/my_themes/my_app_theme.dart';

class MyTextFieldWidget extends StatefulWidget {
   MyTextFieldWidget(
      {Key? key,
      required this.obscureText,
      required this.label,
      required this.hint,
      required this.onChanged,
      this.errorText = "",
      this.showErrorText = false,
      this.controller,
      this.inputFormatters,
      this.maxLength,
      })
      : super(key: key);

  int? maxLength;
  final String label;
  final String hint;
  final String errorText;
  final bool obscureText;
  final bool showErrorText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;

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
    return Column(
      children: [
        TextField( 
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.obscureText ? !_passwordVisible : widget.obscureText,
          onChanged: widget.onChanged,
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            focusColor: MyAppTheme.softBlueColor,
            counter: const Offstage(),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            errorText: widget.showErrorText ? widget.errorText : null,
            labelText: widget.label,
            hintText: widget.hint,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: MyAppTheme.softBlueColor,
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
        ),
        const SizedBox(
          height: 4,
        )
      ],
    );
  }
}