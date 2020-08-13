import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greenify/pages/home/leaderboard/detail.dart';

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40, bottom: 5),
            child: Container(
              height: 45,
              child: new Image.asset(
                  'assets/graphics/leaderboard.png'),
            ),
          ),
          Expanded(
            child: new StreamBuilder(
              stream: Firestore.instance.collection('users').orderBy('points', descending: true).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData) return new Center(child: new CircularProgressIndicator());
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => LeaderboardDetailCard(snapshot.data.documents[index], index),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
