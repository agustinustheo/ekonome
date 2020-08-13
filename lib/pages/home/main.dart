import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greenify/pages/home/main/donate.dart';
import 'package:greenify/pages/home/main/missions.dart';
import 'package:greenify/pages/home/main/nearby.dart';
import 'package:greenify/pages/home/main/notifications.dart';
import 'package:greenify/pages/home/main/redeem_list.dart';
import 'package:greenify/pages/home/main/scanner.dart';
import 'package:greenify/util/session_util.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainPage> {
  String _userID;

  _MainState() {
    getUserLogin().then((val) => setState(() {
          _userID = val;
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Expanded(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height + 185,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: new StreamBuilder(
                        stream: Firestore.instance.collection('users').where("auth_uid", isEqualTo: _userID).snapshots(),
                        builder: (context, snapshot){
                          if(!snapshot.hasData) return new Container();
                          return _renderBody(snapshot.data.documents[0]);
                        }
                      ),
                    ),
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _renderBody(DocumentSnapshot document) {
    return Container(
      height: MediaQuery.of(context).size.height + 185,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 35, bottom: 10),
            child: Container(
              height: 50,
              child: new Image.asset(
                  'assets/graphics/greenify_logo.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: _profileInformation(document)
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Missions(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Nearby(),
          ),
        ],
      ),
    );
  }

  Widget _balanceInformation(DocumentSnapshot document) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: <Widget>[
                    Text(document.data.containsKey('points') ? document['points'].toString() + " GP" : "0 GP",
                        textScaleFactor: 1.3,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                )),
            Row(
              children: <Widget>[_redeemButton(), _donateButton(), _historyButton()],
            )
          ],
        ),
      )
    );
  }

  Widget _profileInformation(DocumentSnapshot document) {
    return Container(
      // color: Colors.black26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
        ),
        color: Color.fromRGBO(63, 63, 63, 1),
      ),
      width: MediaQuery.of(context).size.width - 20,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 15),
              child: _circularImage(document)
            )
          ),
          _balanceInformation(document),
        ],
      ),
    );
  }

  Widget _redeemButton() {
    return FlatButton(
      onPressed: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RedeemList()))
      },
      child: Column(
        children: <Widget>[
          IconTheme(
              data: IconThemeData(color: Colors.white, size: 25),
              child: Icon(Icons.redeem)),
          Text(
            "Redeem",
            style: TextStyle(color: Colors.white),
            textScaleFactor: 1,
          ),
        ],
      ),
    );
  }
  
  Widget _donateButton() {
    return FlatButton(
      onPressed: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Donate()))
      },
      child: Column(
        children: <Widget>[
          IconTheme(
              data: IconThemeData(color: Colors.white, size: 25),
              child: Icon(Icons.attach_money)),
          Text(
            "Donate",
            style: TextStyle(color: Colors.white),
            textScaleFactor: 1,
          ),
        ],
      ),
    );
  }

  Widget _historyButton() {
    return FlatButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Notifications()));
      },
      child: Column(
        children: <Widget>[
          IconTheme(
              data: IconThemeData(color: Colors.white, size: 25),
              child: Icon(Icons.notifications)),
          Text(
            "Notifications",
            style: TextStyle(color: Colors.white),
            textScaleFactor: 1,
          )
        ],
      ),
    );
  }

  ImageProvider _loadImage(DocumentSnapshot document){
    if(document.data.containsKey('profile_pic_url')){
      return NetworkImage(document['profile_pic_url']);
    }
    return AssetImage('assets/graphics/user/anonymous.jpg');
  }

  Widget _nameProfile(DocumentSnapshot document){
    if(document.data.containsKey('username')){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Text(
            document['fullname'].toString(),
            textScaleFactor: 1.3,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          new Text(
            "@" + document['username'].toString(),
            textScaleFactor: 1,
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Text(
          document['email'].toString(),
          textScaleFactor: 1.3,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Widget _circularImage(DocumentSnapshot document) {
    return new Center(
        child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: new Container(
                width: 50.0,
                height: 50.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: _loadImage(document)
                  )
                )
              )
            ),
            _nameProfile(document)
          ],
        ),
        FlatButton(
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ScannerPage()))
          },
          child: IconTheme(
            data: IconThemeData(color: Colors.white, size: 30),
            child: Icon(Icons.settings_overscan)
          ),
        ),
      ],
    ));
  }
}
