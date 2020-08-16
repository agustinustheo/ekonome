import 'package:EkonoMe/API/auth/session_service.dart';
import 'package:EkonoMe/pages/widgets/greenify_examples/screen/mission_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Missions extends StatefulWidget {
  Missions({Key key}) : super(key: key);

  @override
  _MissionsState createState() => _MissionsState();
}

class _MissionsState extends State<Missions> {
  String _userID;
  String _userDocRefrence;

  _MissionsState() {
    SessionService.getUserLogin().then((val) => setState(() {
          _userID = val;
          SessionService.getUserByAuthUID(_userID).then((val) => setState(() {
                _userDocRefrence = val.documentID;
              }));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Color.fromRGBO(63, 63, 63, 1),
        ),
        width: MediaQuery.of(context).size.width - 20,
        child: Padding(
            padding: EdgeInsets.only(left: 15, top: 15),
            child:
                Column(children: <Widget>[_missionHeader(), MissionList()])));
  }

  Widget _missionList() {
    return Container(
        padding: EdgeInsets.only(left: 0, top: 0),
        child: new StreamBuilder(
            stream: Firestore.instance.collection('missions').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return new Container();
              return Column(children: <Widget>[
                _missionItem(snapshot.data.documents[0]),
                _missionItem(snapshot.data.documents[1]),
                _missionItem(snapshot.data.documents[2])
              ]);
            }));
  }

  Widget _missionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Missions",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              textScaleFactor: 1.7,
            ),
            Text("Are you ready to make the world greener?",
                style: TextStyle(color: Colors.white)),
          ],
        ),
        FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => _missionList()));
          },
          child: Text(
            "MORE",
            style: TextStyle(color: Colors.white),
            textScaleFactor: 1.4,
          ),
        )
      ],
    );
  }

  Widget _missionItem(DocumentSnapshot document) {
    return Container(
      child: Padding(
          padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
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
                    textScaleFactor: 1.3,
                  ),
                  Text(
                    document['base_points'].toString() + " GP",
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
