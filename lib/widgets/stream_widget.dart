import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/models/ChartItemModel.dart';
import 'package:EkonoMe/widgets/chart_bar_widget.dart';
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

Widget chartStream(Map<String, Map<String, dynamic>> query, {String orderByColumn = "", bool ascending = true, bool separator = false}){
  return StreamBuilder(
    stream: orderByColumn == "" ? FirestoreHelper.firestoreQueryBuilder("templates", query: query).snapshots() : FirestoreHelper.firestoreQueryBuilder("templates", query: query).orderBy(orderByColumn, descending: true).snapshots(),
    builder: (context, snapshot){
      if(!snapshot.hasData) return new Center(child: circularProgress());

      List<dynamic> targets = snapshot.data.documents[0].data['targets'];
      List<dynamic> funds = snapshot.data.documents[0].data['funds'];
      List<dynamic> titles = snapshot.data.documents[0].data['titles'];
      return ListView.builder(
        itemBuilder: (context, index) => ChartBar(ChartItemModel(
          targets[index] == 0 ? 0 : funds[index] / targets[index] > 1 ? 1 : funds[index] / targets[index],
          titles[index],
          ("Rp. " + funds[index].toString() + "/" + targets[index].toString()).toString()
        )),
        itemCount: titles.length,
      );
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