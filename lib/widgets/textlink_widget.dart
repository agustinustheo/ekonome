import 'package:flutter/material.dart';

Widget textLink(String text, Function function){
  return InkWell(
      child: Text(
        text,
        style: new TextStyle(
          fontSize: 14.0, 
          color: Colors.grey[700],
        ),
      ),
      onTap: function
  );
}