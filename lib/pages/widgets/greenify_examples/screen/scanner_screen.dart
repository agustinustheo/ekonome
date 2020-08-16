import 'dart:async';

import 'package:EkonoMe/API/auth/session_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => new _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  // ignore: unused_field
  String barcode = "", _userID;
  bool _visible = true;

  Timer _animationTimer;

  @override
  void dispose() {
    _animationTimer?.cancel();
    _animationTimer = null;
    super.dispose();
  }

  _QRScannerState() {
    _animationTimer = Timer.periodic(
        Duration(milliseconds: 700),
        (Timer t) => setState(() {
              _visible = !_visible;
            }));

    SessionService.getUserLogin().then((val) => setState(() {
          _userID = val;
        }));
  }

  // ignore: unused_element
  void _goHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 200,
                  child: RaisedButton(
                    color: Colors.black,
                    child: AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        'Tap Me to Scan',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    // // onPressed: () async {
                    // //   try {
                    // //     dynamic barcode = await BarcodeScanner.scan();
                    // //     if (barcode != null) {
                    // //       setState(() {
                    // //         this.barcode = barcode;
                    // //       });
                    // //       int points;
                    // //       SessionService.getUserByAuthUID(_userID)
                    // //           .then((val) => {
                    // //                 points = val.data['points'] + 35,
                    // //                 Firestore.instance
                    // //                     .collection('users')
                    // //                     .document(val.documentID)
                    // //                     .updateData({'points': points}),
                    // //                 Alert(
                    // //                   context: context,
                    // //                   type: AlertType.success,
                    // //                   title: "Succesful",
                    // //                   desc: "Succesful redeemed 35 GPs",
                    // //                   buttons: [
                    // //                     DialogButton(
                    // //                       child: Text(
                    // //                         "OK",
                    // //                         style: TextStyle(
                    // //                             color: Colors.white,
                    // //                             fontSize: 20),
                    // //                       ),
                    // //                       onPressed: () => _goHome(),
                    // //                       width: 120,
                    // //                     )
                    // //                   ],
                    // //                 ).show(),
                    // //                 SessionService.sendNotification(
                    // //                     'QR Scanner',
                    // //                     'You\'ve got 35 points for scanning your plasticless grocery receipt! Great job!',
                    // //                     _userID)
                    // //               });
                    // //     }
                    // //   } on FormatException {
                    // //     _goHome();
                    // //   } on PlatformException catch (error) {
                    // //     if (error.code == BarcodeScanner.CameraAccessDenied) {
                    // //       setState(() {
                    // //         this.barcode = 'Camera access not allowed';
                    // //       });
                    // //     } else {
                    // //       setState(() {
                    // //         this.barcode = 'Error: $error';
                    // //       });
                    // //     }
                    // //     Alert(
                    // //       context: context,
                    // //       type: AlertType.error,
                    // //       title: "Error",
                    // //       desc: "$barcode",
                    // //       buttons: [
                    // //         DialogButton(
                    // //           child: Text(
                    // //             "OK",
                    // //             style: TextStyle(
                    // //                 color: Colors.white, fontSize: 20),
                    // //           ),
                    // //           onPressed: () => _goHome,
                    // //           width: 120,
                    // //         )
                    // //       ],
                    // //     ).show();
                    // //   }
                    // },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
