import 'package:flutter/material.dart';
import 'package:services_joined/src/utils/appcolor.dart';

class TitleSubtitleCell extends StatelessWidget {
  final String title;
  final String subtitle;
 final Color color;
  const TitleSubtitleCell({Key? key, required this.title, required this.subtitle, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration:customDecorator(color,4,4,4,4),
      child: Column(
        children: [
           Text(
              title,
              style: const TextStyle(
                  color:Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),

          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
  BoxDecoration customDecorator(
      themeprovider, double bLeft, double bRight, double tLeft, double tRigt) {
    return BoxDecoration(
      gradient: LinearGradient(
          colors: [
            Colors.white,
            themeprovider.withOpacity(0.5),
            themeprovider,


          ]
      ),
      boxShadow: [
        BoxShadow(
            color: themeprovider,
            blurStyle: BlurStyle.outer,
            spreadRadius: 2,
            blurRadius: 2)
      ],
      color: Colors.white54,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bLeft),
          bottomRight: Radius.circular(bRight),
          topLeft: Radius.circular(tLeft),
          topRight: Radius.circular(tRigt)),
    );
  }
}