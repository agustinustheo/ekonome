import 'package:EkonoMe/pages/auth/login.dart';
import 'package:EkonoMe/pages/auth/register.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EkonoMe',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage()
    );
  }
}
