import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenify/pages/auth/login.dart';
import 'package:greenify/pages/home.dart';
import 'package:greenify/util/session_util.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  bool _visible = true;

  Timer _animationTimer;

  @override
  void dispose() {
    _animationTimer?.cancel();
    _animationTimer = null;
    super.dispose();
  }

  _SplashState() {
    _animationTimer = Timer.periodic(
      Duration(milliseconds: 700), 
      (Timer t) => setState((){
        _visible = !_visible;
      })
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: new Image.asset(
                  'assets/graphics/spinning_globe.gif',
                  width: 150.0,
                  height: 150.0,
                )
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20.0),
                child: new Image.asset(
                  'assets/graphics/greenify_logo.png',
                  height: 50.0,
                )
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20.0),
                child: AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Touch To Start',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pressStart2p(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: (){
          getUserLogin().then((authUid) => {
            if(authUid != null && authUid != "")
              Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => HomePage()) )
            else
              Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => LoginPage()) )
          });
        },
      ),
    );
  }
}