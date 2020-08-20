import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/widgets/circularprogress_widget.dart';
import 'package:EkonoMe/widgets/profile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget profileStream(String authUid, {String orderByColumn = "", bool ascending = true}){
  var q = FirestoreHelper.firestoreQueryBuilder("profile", query: {"=": {"auth_uid": authUid}});
  return StreamBuilder(
    stream: orderByColumn == "" ? q.snapshots() : q.orderBy(orderByColumn, descending: ascending).snapshots(),
    builder: (context, snapshot) {
      if(!snapshot.hasData) return new Center(child: circularProgress());
      return Profile(snapshot.data.documents[0]);
    }
  );
}

Widget templateStream(String authUid, {String orderByColumn = "", bool ascending = true}){
  var q = FirestoreHelper.firestoreQueryBuilder("templates", query: {"=": {"auth_uid": authUid}});
  return StreamBuilder(
    stream: orderByColumn == "" ? q.snapshots() : q.orderBy(orderByColumn, descending: ascending).snapshots(),
    builder: (context, snapshot) {
      if(!snapshot.hasData) return new Center(child: circularProgress());
      return Template(snapshot.data.documents[0]);
    }
  );
}

Widget singleStream(String collectionName, {String orderByColumn = "", bool ascending = true}){
  return StreamBuilder(
    stream: orderByColumn == "" ? Firestore.instance.collection(collectionName).snapshots() : Firestore.instance.collection(collectionName).orderBy(orderByColumn, descending: true).snapshots(),
    builder: (context, snapshot){
      if(!snapshot.hasData) return new Center(child: circularProgress());
      return Container();
    }
  );
}

Widget listStream(String collectionName, {String orderByColumn = "", bool ascending = true, bool separator = false}){
  return StreamBuilder(
    stream: orderByColumn == "" ? Firestore.instance.collection(collectionName).snapshots() : Firestore.instance.collection(collectionName).orderBy(orderByColumn, descending: true).snapshots(),
    builder: (context, snapshot){
      if(!snapshot.hasData) return new Center(child: circularProgress());
      if(!separator){
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) => Container(),
        );
      }
      else{
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) => Container(),
        );
      }
    }
  );
}