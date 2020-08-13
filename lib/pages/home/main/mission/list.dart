import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greenify/util/session_util.dart';

class MissionList extends StatefulWidget {
  MissionList({Key key}) : super(key: key);

  @override
  _MissionListState createState() => _MissionListState();
}

class _MissionListState extends State<MissionList> {
  String _userID;
  String _userDocRefrence;

  _MissionListState() {
    getUserLogin().then((val) => setState(() {
          _userID = val;
          getUserByAuthUID(_userID).then((val) => setState(() {
                _userDocRefrence = val.documentID;
              }));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Missions"),
        ),
        body: Container(color: Colors.black, child: _listView()));
  }

  Container _listView() {
    return Container(
        child: new StreamBuilder(
            stream: Firestore.instance.collection('missions').snapshots(),
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Color.fromRGBO(63, 63, 63, 1)),
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: MediaQuery.of(context).size.width - 10,
      // color: Color.fromRGBO(63, 63, 63, 1),
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
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textScaleFactor: 1.7,
                  ),
                  Text(
                    document['base_points'].toString(),
                    textScaleFactor: 0.9,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    document['description'].toString(),
                    textScaleFactor: 0.9,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: new StreamBuilder(
                          stream: Firestore.instance
                              .collection('users')
                              .document(_userDocRefrence)
                              .collection('missions')
                              .where('mission_id',
                                  isEqualTo: document.documentID)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data.documents.length == 0) {
                              return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: _progress(0, 5));
                            }
                            return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: _progress(
                                    snapshot.data.documents[0]['progress'], 5));
                          }))
                ],
              )),
            ],
          )),
    );
  }

  List<Widget> _progress(int completed, int limit) {
    List<Widget> progressHearts = List<Widget>();
    for (var i = 0; i < completed; i++) {
      progressHearts.add(
        IconTheme(
            data: IconThemeData(color: Colors.red),
            child: Icon(Icons.favorite)),
      );
    }

    var remaining = limit - completed;
    for (var i = 0; i < remaining; i++) {
      progressHearts.add(
        IconTheme(
            data: IconThemeData(color: Colors.white),
            child: Icon(Icons.favorite)),
      );
    }

    return progressHearts;
  }
}
