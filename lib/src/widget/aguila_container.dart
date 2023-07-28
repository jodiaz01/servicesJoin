import 'package:flutter/material.dart';

class AguilaThemeContainer extends StatelessWidget {
  AguilaThemeContainer({super.key, this.child});

  Widget? child;

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          // padding: const EdgeInsets.symmetric(horizontal: 15),
          height: sizeScreen.height * 0.5,
          width: sizeScreen.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            image: DecorationImage(
              image: AssetImage('assets/images/img_agui.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              // borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: child)),
      ],
    );
  }
}
