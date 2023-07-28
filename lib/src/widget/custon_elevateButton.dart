import 'package:flutter/material.dart';

class CustomElevateButton extends StatelessWidget {
  CustomElevateButton(
      {super.key,
        required this.function,
        required this.color,
        required this.width,
        required this.height,
        this.text,
        required this.icon});

  final Function () function;

  final Color color;
  final double width;
  final double height;
  final String? text;
  Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            fixedSize: Size(width, height),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        icon: icon,
        label: Text(text ?? ''),
        onPressed: function);
  }
}
