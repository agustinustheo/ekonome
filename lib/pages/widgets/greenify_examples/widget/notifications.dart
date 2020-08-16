import 'package:EkonoMe/API/auth/session_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String _userID;

  _NotificationsState() {
    SessionService.getUserLogin().then((val) => setState(() {
          _userID = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: Container(color: Colors.black, child: _listView()));
  }

  Container _listView() {
    return Container(
        child: new StreamBuilder(
            stream: Firestore.instance
                .collection('notifications')
                .where('user_id', isEqualTo: _userID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return new Container();
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _missionItem(snapshot.data.documents[index]),
              );
            }));
  }

  Widget _missionItem(DocumentSnapshot document) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Color.fromRGBO(63, 63, 63, 1)),
      width: MediaQuery.of(context).size.width - 10,
      child: Padding(
          padding: EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    document['title'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                    textScaleFactor: 1.7,
                  ),
                  SizedBox(height: 3),
                  SizedBox(height: 10),
                  Text(
                    document['description'].toString(),
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10)
                ],
              )),
            ],
          )),
    );
  }
}
