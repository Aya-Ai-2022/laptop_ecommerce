import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultFieldForm extends StatelessWidget {
  TextEditingController controller;
  TextInputType keyboard;
  var valid;
  String? label;
  String? hint;
  IconData? prefix;
  bool show;

  var tap;

  var onchange;
  var onSubmit;
  IconData? suffix;
  Function()? suffixPress;
  TextStyle? labelStyle;
  TextStyle? hintStyle;

  DefaultFieldForm({
    Key? key,
    required this.controller,
    required this.keyboard,
    required this.valid,
    this.label,
    this.hint,
    this.prefix,
    this.show = false,
    this.tap,
    this.onchange,
    this.onSubmit,
    this.suffix,
    this.suffixPress,
    this.labelStyle,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: valid,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle,
        labelText: label,
        labelStyle: labelStyle,
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[500]!),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        prefixIcon: Icon(prefix, color: Colors.black),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix), onPressed: suffixPress, color: Colors.black)
            : null,
      ),
      keyboardType: keyboard,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      obscureText: show,
      onTap: tap,
    );
  }
}
