import 'package:flutter/material.dart';
import 'package:greenify/pages/home/scanner.dart';

class ScannerPage extends StatefulWidget {
  ScannerPage({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Scanner"),
        ),
        body: QRScanner()
    );
  }
}
