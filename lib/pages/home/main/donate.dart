import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greenify/util/session_util.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Donate extends StatefulWidget {
  Donate({Key key}) : super(key: key);

  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  String _userID;

  _DonateState() {
    getUserLogin().then((val) => setState(() {
      _userID = val;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Donate"),
        ),
        body: Container(color: Colors.black, child: _listView()));
  }

  Container _listView() {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection('donations')
          .snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return new Container();
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => _missionItem(snapshot.data.documents[index]),
          );
        }
      )
    );
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
                        fontWeight: FontWeight.bold, color: Colors.green),
                    textScaleFactor: 1.7,
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Total donations: " + document['points'].toString() + " GP",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    document['description'].toString(),
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.maxFinite, // set width to maxFinite
                    child: OutlineButton(
                      onPressed: () {
                        _onDonate(document);
                      },
                      borderSide: BorderSide(color: Colors.white),
                      child: Text(
                        "DONATE",
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 1.3,
                      ),
                    ),
                  )
                ],
              )),
            ],
          )),
    );
  }

  void _onDonate(DocumentSnapshot document) {
    getUserByAuthUID(_userID).then((val) => {
      if(val['points'] > 100){
        Firestore.instance.collection('users').document(val.documentID)
          .updateData({
            'points': val['points'] - 100
          }),
        Firestore.instance.collection('donations').document(document.documentID)
          .updateData({
            'points': document['points'] + 100
          }),
        Alert(
          context: context,
          type: AlertType.success,
          title: "You Donated!",
          desc:
              "Thank you for making our world better!",
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
        sendNotification(
          document['title'], 
          'Thank you! You\'ve donated 100 points for ' + document['title'].toString() + '!',
          _userID
        )
      }
      else{
        Alert(
          context: context,
          type: AlertType.error,
          title: "You do not have enough points",
          desc:
              "Sorry you can't donate now. You need to gather more points.",
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
      }
    });
  }
}
