import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> messagekey =
  GlobalKey<ScaffoldMessengerState>();

  static navigatorTo (String routeName){
    return navigatorKey.currentState?.pushNamed(routeName);
  }
  static replaceTo (String routeName){
    return navigatorKey.currentState?.pushReplacementNamed(routeName);
  }
  static moveTo (String routeName){
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName,(route) => false);
  }


  static pasaTo (String routeName){
    return navigatorKey.currentState?.pushNamed(routeName);
  }


}