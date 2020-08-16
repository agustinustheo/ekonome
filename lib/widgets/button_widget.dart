import 'package:flutter/material.dart';

Widget button(String text, Function function){
  return FlatButton(
    color: Colors.greenAccent,
    textColor: Colors.white,
    splashColor: Colors.greenAccent[700],
    onPressed: function,
    child: Text(
      text,
      style: TextStyle(fontSize: 16.0),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(15.0)
    ),
  );
}

Widget fullButton(String text, Function function){
  return SizedBox(
    width: double.infinity,
    child: button(text, function),
  );
}