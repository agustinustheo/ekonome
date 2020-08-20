import 'package:flutter/material.dart';

class EkonomeAppBar {
  final String title;

  EkonomeAppBar(this.title);

  AppBar getAppBar() {
    return AppBar(
      title: Text(this.title),
      backgroundColor: Colors.greenAccent[200],
    );
  }
}
