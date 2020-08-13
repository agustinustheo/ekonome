import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  static void insertToFirestore(String collectionName, Map data){
    Firestore.instance.collection(collectionName).document()
      .setData(data);
  }
}