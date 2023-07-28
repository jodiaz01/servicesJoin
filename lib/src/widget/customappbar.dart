import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_joined/provider/theme/theme.dart';

class CustomAppbar extends StatelessWidget {
  final Widget child;
  final Widget? returnIcons, title, icon;
  final double elevation;

  const CustomAppbar(
      {super.key,
      required this.child,
      this.returnIcons,
      this.title,
      this.icon,
      required this.elevation});

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeSetting>(context);
    final sizeScreen = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        borderRadius:
            BorderRadius.horizontal(left: Radius.zero, right: Radius.zero),
        gradient:
            LinearGradient(colors: [Colors.transparent, Colors.transparent]),
      ),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              leading: returnIcons ?? SizedBox(),
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 0, top: 20, bottom: 10),
                child: title,
              ),
              backgroundColor: themeprovider.currentTheme.primaryColor,
              expandedHeight: sizeScreen.height * elevation,
              elevation: 0,
              leadingWidth: 0,
              flexibleSpace: Align(
                alignment: Alignment.center,
                child: icon,
              ),
            ),
          ];
        },
        body: Container(

          decoration: BoxDecoration(
            color: themeprovider.currentTheme.secondaryHeaderColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child:child


          ,
        ),
      ),
    );
  }
}
/*
*  Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: sizeScreen.height,
                width: sizeScreen.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/img_agui.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: child),
              ),
* */
