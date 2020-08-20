import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firestore_helper.dart';

class SessionHelper{
  static Future<bool> saveUserLogin(FirebaseUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("user", user.uid);
  }

  static Future<bool> checkSession() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("user");
  }

  static Future<String> getUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }

  static Future<bool> removeUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("user", "");
  }

  static Future<DocumentSnapshot> getUserByAuthUID(String authUid) async {
    QuerySnapshot data = await FirestoreHelper
    .getFirestoreDocuments(
      "users", 
      query: {
        "=": 
        {
          "auth_uid": authUid
        }
      }
    );
    return data.documents[0];
  }

  static Future<DocumentSnapshot> getUserByUsername(String username) async {
    QuerySnapshot data = await FirestoreHelper
    .getFirestoreDocuments(
      "users", 
      query: {
        "=": 
        {
          "username": username
        }
      }
    );
    return data.documents[0];
  }
}
