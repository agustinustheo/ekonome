import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greenify/util/session_util.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EventDetailView extends StatefulWidget {
  final DocumentSnapshot document;
  EventDetailView(this.document);

  @override
  _EventDetailState createState() => _EventDetailState(document);
}

class _EventDetailState extends State<EventDetailView> {
  final DocumentSnapshot document;
  String _userID;

  _EventDetailState(this.document) {
    getUserLogin().then((val) => setState(() {
          _userID = val;
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(document['name'].toString()),
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 225,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      image: DecorationImage(
                          image: NetworkImage(document['image_url'].toString()),
                          fit: BoxFit.cover)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          document['name'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Text(
                        document['duration'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      Text(
                        " - ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        document['location'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          document['description'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              document['points'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            Text(
                              " Points Available!",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  child: new SizedBox(
                    width: 255.0,
                    child: RaisedButton(
                      onPressed: () => {
                        sendRedeemable(document['name'].toString(), document['points'], document['description'].toString(), _userID),
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "You are in attendance!",
                          desc:
                              "Welcome to " + document['name'].toString() + "!",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show(),
                      },
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      child: Text(
                        'Attend',
                        style: new TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
