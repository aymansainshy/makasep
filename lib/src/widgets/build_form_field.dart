import 'package:flutter/material.dart';

class BuilFormField extends StatefulWidget {
  final Function onFieldSubmitted;
  final Function onSaved;
  final Function validator;
  final String fieldName;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final double contentPadding;
  final String hintText;
  final TextStyle hintStyle;
  final TextEditingController controller;
  final bool obscureText;
  final String initialValue;
  final int maxLines;

  const BuilFormField({
    Key key,
    @required this.textInputAction,
    @required this.contentPadding,
    @required this.keyboardType,
    @required this.validator,
    this.fieldName,
    this.hintStyle,
    this.hintText,
    this.prefixIcon,
    this.initialValue,
    this.onFieldSubmitted,
    this.onSaved,
    this.maxLines,
    this.focusNode,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _BuilFormFieldState createState() => _BuilFormFieldState();
}

class _BuilFormFieldState extends State<BuilFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.fieldName,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        filled: true,
        contentPadding: EdgeInsets.all(widget.contentPadding),
        prefixIcon: widget.prefixIcon,
        errorBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      cursorColor: Colors.grey,
      validator: widget.validator,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
    );
  }
}
