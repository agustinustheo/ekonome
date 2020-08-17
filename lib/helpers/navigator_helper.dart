import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorHelper{
  static Future<dynamic> push(BuildContext context, Widget widget){
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => widget)
    );
  }
  static Future<dynamic> pushReplacement(BuildContext context, Widget widget){
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => widget)
    );
  }
  static void pop(BuildContext context){
    return Navigator.pop(context);
  }
}