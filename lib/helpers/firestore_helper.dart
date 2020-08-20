import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper{
  static void insertToFirestore(String collectionName, Map<String, dynamic> data) {
    Firestore.instance.collection(collectionName).document().setData(data);
  }
  
  static void updateFirestore(String collectionName, String id, Map<String, dynamic> data) {
    Firestore.instance.collection(collectionName).document(id).updateData(data);
  }

  static Query _addQuery(Query q, Map<String, Map<String, dynamic>> data){
    for(var type in data.entries){
      if(type.key == "="){
        for(var item in type.value.entries){
          q = q.where(item.key, isEqualTo: item.value);
        }
      }
    }
    return q;
  }

  static Future<QuerySnapshot> getFirestoreDocuments(String collectionName, {Map<String, Map<String, dynamic>> query}) async{
    Query q = Firestore.instance
        .collection(collectionName);
    if(query != null) q = _addQuery(q, query);
    return await q.getDocuments();
  }

  static Future<bool> firestoreIfExists(String collectionName, Map<String, Map<String, dynamic>> data) async{
    Query q = Firestore.instance
        .collection(collectionName);
    q = _addQuery(q, data);
    QuerySnapshot res = await q.getDocuments();
    return res.documents.isNotEmpty;
  }
}
