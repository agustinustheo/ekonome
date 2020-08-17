import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper{
  static void insertToFirestore(String collectionName, Map<String, dynamic> data) {
    Firestore.instance.collection(collectionName).document().setData(data);
  }
}
