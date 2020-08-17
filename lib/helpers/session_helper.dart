import 'dart:async';
import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionHelper{
  static Future<bool> saveUserLogin(FirebaseUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("user", user.uid);
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
    Query user = Firestore.instance
        .collection('users')
        .where("auth_uid", isEqualTo: authUid);
    QuerySnapshot data = await user.getDocuments();
    return data.documents[0];
  }

  static Future<DocumentSnapshot> getUserByUsername(String username) async {
    Query user = Firestore.instance
        .collection('users')
        .where("username", isEqualTo: username);
    QuerySnapshot data = await user.getDocuments();
    return data.documents[0];
  }
}
