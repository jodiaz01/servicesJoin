import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ServiPro/provider/theme/theme.dart';

class CustomInput {

  static InputDecoration myInputStyles(
      {required String hint, required String label, required IconData icon,required BuildContext context}) {
    final themeprovider = Provider.of<ThemeSetting>(context);

     final Color color = themeprovider.currentTheme == ThemeData.dark() ? Colors.white.withOpacity(0.4) : Colors.black87;

    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(14.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(14.0)),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(
        icon,
        color:color,
      ),
      hintStyle: TextStyle(color:color),
      labelStyle: TextStyle(color:color),
    );
  }

  static InputDecoration searchInputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: Colors.grey,
      ),
      labelStyle: TextStyle(color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration formInputStyles(
      {required String hint, required String label, required IconData icon}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(14.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(14.0)),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: Colors.black54,
      ),
      hintStyle: TextStyle(color: Colors.blue),
      labelStyle: TextStyle(color: Colors.black54),
    );
  }

  static InputDecoration dropDownStyles(
      {required String hint, required String label, required IconData icon}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(14.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(14.0)),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: Colors.black.withOpacity(0.5),
      ),
      hintStyle: TextStyle(color: Colors.blue),
      labelStyle: TextStyle(color: Colors.black),
    );
  }
}
