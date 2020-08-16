import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget title(String text){
  return Text(
    text,
    style: new TextStyle(
      color: Colors.grey[800],
      fontSize: 30.0
    ),
  );
}

Widget subtitle(String text){
  return Text(
    text,
    style: new TextStyle(
      color: Colors.grey[800],
      fontSize: 18.0
    ),
  );
}