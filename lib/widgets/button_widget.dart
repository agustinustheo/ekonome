import 'package:flutter/material.dart';

Widget button(Function function, {String text, Icon icon, double radius}){
  return FlatButton(
    color: Colors.greenAccent,
    textColor: Colors.white,
    splashColor: Colors.greenAccent[700],
    onPressed: function,
    child: text == null? icon : Text(
      text,
      style: TextStyle(fontSize: 16.0),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(radius??15.0)
    ),
  );
}

Widget helpbutton(Function function, {String text, Icon icon, double radius}){
  return SizedBox(
    width: 70,
    child: button(function, text: text, icon: icon, radius: radius),
  );
}

Widget fullButton(Function function, {String text, Icon icon, double radius}){
  return SizedBox(
    width: double.infinity,
    child: button(function, text: text, icon: icon, radius: radius),
  );
}