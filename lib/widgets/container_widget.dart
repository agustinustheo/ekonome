import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget container(Widget child) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        child: child,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8
            ),
          ]
        ),
      )
    ]
  );
}
