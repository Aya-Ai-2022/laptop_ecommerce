import 'package:flutter/material.dart';


// ignore: must_be_immutable
class DefaultButton extends StatelessWidget {
  Widget buttonWidget;
  Function() function;
  double width;
  Color? backgroundColor = Color.fromARGB(255, 59, 9, 100);
  bool isUpperCase;
  double radius;
  double height;
  Color borderColor;
  DefaultButton({
    super.key,
    this.height = 50,
    required this.buttonWidget,
    required this.function,
    this.backgroundColor,
    this.width = double.infinity,
    this.isUpperCase = true,
    this.radius = 10.0,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        child: MaterialButton(
          onPressed: function,
          child: buttonWidget,
        ),
      ),
    );
  }
}
