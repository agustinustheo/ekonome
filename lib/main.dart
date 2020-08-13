import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenify/pages/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EkonoMe',
      theme: ThemeData(
        textTheme: GoogleFonts.vt323TextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.green,
      ),
      home: SplashPage(),
    );
  }
}
