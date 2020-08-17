import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'firestore_helper.dart';
import 'session_helper.dart';

class AuthHelper{
  Future<bool> signIn(List<String> credentials) async {
    try {
      // Authenticate user
      AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: credentials[0], password: credentials[1]);

      // Get user
      FirebaseUser user = authResult.user;

      // Verify email
      if (user.isEmailVerified) {
        SessionHelper.saveUserLogin(user);
        return user.isEmailVerified;
      } else {
        throw ("Error email is not verified!");
      }
    } catch (signInError) {
      if (signInError is PlatformException &&
          signInError.code == 'ERROR_WRONG_PASSWORD') {
        throw ("Error email and password doesn't match!");
      } else {
        throw ("Error an unknown exception occured.");
      }
    }
  }

  // ignore: missing_return
  Future<FirebaseUser> signUp(List<String> credentials) async {
    try {
      // Register user
      AuthResult authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: credentials[0], password: credentials[1]);
      FirebaseUser user = authResult.user;

      // Send verification email
      user.sendEmailVerification();

      // Save to users with custom document ID
      FirestoreHelper.insertToFirestore("users",
          {"auth_uid": user.uid, "email": credentials[0]});

      return user;
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          throw ("Email is already used!\nPlease use another email to sign up.");
        }
      } else {
        throw ("Error an unknown exception occured.");
      }
    }
  }
}
