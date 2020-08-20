import 'package:flutter/material.dart';

Widget circularProgress(){
  return Container(padding: EdgeInsets.only(top: 5.0, bottom: 5.0), child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent))));
}