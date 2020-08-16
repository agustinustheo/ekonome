import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget background(Widget child){
  return Scaffold(
    backgroundColor: Colors.white,
    body: Stack(
      children: [
        Positioned(
          top: -500,
          left: -300,
          child: bigCircle(Colors.greenAccent[100]),
        ),
        Positioned(
          bottom: -500,
          right: -300,
          child: bigCircle(Colors.greenAccent[100]),
        ),
        Positioned.fill(
          child: child
        ),
      ],
    )
  );
}

Widget bigCircle(Color color){
  return new Container(
    width: 800.0,
    height: 750.0,
    decoration: new BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
  );
}