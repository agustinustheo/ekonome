import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorService{
  static Future<dynamic> pushReplace(BuildContext context, Widget widget){
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => widget)
    );
  }
}