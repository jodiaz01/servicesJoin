
import 'package:flutter/material.dart';
import 'package:ServiPro/src/utils/appcolor.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final IconData icon;
  final TextInputType textInputType;
  final bool isObscureText;
  final Widget? rightIcon;

  const RoundTextField(
      {Key? key,
        this.textEditingController,
        required this.hintText,
        required this.icon,
        required this.textInputType,
        this.isObscureText = false,
        this.rightIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightGrayColor,
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: isObscureText,
        decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            prefixIcon: Icon(icon),
            suffixIcon: rightIcon,
            hintStyle: TextStyle(fontSize: 12, color: AppColors.grayColor)),
      ),
    );
  }
}
