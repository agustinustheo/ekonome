import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorHelper{
  static Future<dynamic> push(BuildContext context, Widget widget, String route){
    return Navigator.of(context).push(
      MaterialPageRoute(settings: RouteSettings(name: route), builder: (context) => widget)
    );
  }
  static Future<dynamic> pushReplacement(BuildContext context, Widget widget, String route){
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(settings: RouteSettings(name: route), builder: (context) => widget)
    );
  }
  static void pop(BuildContext context){
    return Navigator.pop(context);
  }
  static void popUntil(BuildContext context, String route){
    return Navigator.of(context).popUntil(ModalRoute.withName(route));
  }
}