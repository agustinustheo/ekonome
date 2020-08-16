import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget singleStream(String collectionName, {String orderByColumn = "", bool ascending = true}){
  return StreamBuilder(
    stream: orderByColumn == "" ? Firestore.instance.collection(collectionName).snapshots() : Firestore.instance.collection(collectionName).orderBy(orderByColumn, descending: true).snapshots(),
    builder: (context, snapshot){
      if(!snapshot.hasData) return new Center(child: new CircularProgressIndicator());
      return Container();
    }
  );
}

Widget listStream(String collectionName, {String orderByColumn = "", bool ascending = true, bool separator = false}){
  return StreamBuilder(
    stream: orderByColumn == "" ? Firestore.instance.collection(collectionName).snapshots() : Firestore.instance.collection(collectionName).orderBy(orderByColumn, descending: true).snapshots(),
    builder: (context, snapshot){
      if(!snapshot.hasData) return new Center(child: new CircularProgressIndicator());
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