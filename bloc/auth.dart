import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firestore_service.dart';
import 'session.dart';

Future<void> signIn(BuildContext context, GlobalKey<FormState> formKey, String email, String password) async {
  final formState = formKey.currentState;
  if (formState.validate()) {
    formState.save();
    try {
      AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      if (user.isEmailVerified) {
        saveUserLogin(user);
      }
      else {
        throw("Error email is not verified!"); 
      }
    } 
    catch (signInError) {
      if (signInError is PlatformException && signInError.code == 'ERROR_WRONG_PASSWORD') {
        throw("Error email and password doesn't match!");
      }
      else{
        throw(signInError);
      }
    }
  }
}

Future<void> signUp(BuildContext context, GlobalKey<FormState> formKey, String email, String password) async{
  final formState = formKey.currentState;
  if(formState.validate()){
    formState.save();
    try{
      // Register user
      AuthResult authResult  = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      FirebaseUser user = authResult.user;

      // Send verification email
      user.sendEmailVerification();

      // Save to users with custom document ID
      FirestoreService.insertToFirestore("users", {
        "auth_uid": user.uid,
        "email": email,
        "points": 0
      });
    }
    catch(signUpError){
      if(signUpError is PlatformException) {
        if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          throw("Email already exists!");
        }
      }
      else{
        throw(signUpError);
      }
    }
  }
}