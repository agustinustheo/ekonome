import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenify/pages/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                    bottom: 25.0,
                  ),
                  child: new Image.asset(
                    'assets/graphics/greenify_logo.png'
                  ),
                ),
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  child: new SizedBox(
                    width: 275.0,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      validator: (input){
                        if(input.isEmpty){
                          return 'Please type an email';
                        }
                      },
                      onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  child: new SizedBox(
                    width: 275.0,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      validator: (input){
                        if(input.isEmpty){
                          return 'Please provide a password';
                        }
                        else if(input.length < 6){
                          return 'Your password needs to be atleast 6 characters';
                        }
                      },
                      onSaved: (input) => _password = input,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  child: new SizedBox(
                    width: 255.0,
                    child: RaisedButton(
                      onPressed: signUp,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      child: Text(
                        'Play',
                        style: new TextStyle(
                          fontSize: 24.0
                        ),
                      ),
                    ),
                  ),
                ),
                new InkWell(
                    child: Text(
                      'Already have an account? Login here',
                      style: new TextStyle(
                        fontSize: 16.0, 
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage())
                      );
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }