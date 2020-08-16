import '../../greenify_examples/widget/leaderboard_detail_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
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
              child: new Image.asset('assets/graphics/leaderboard.png'),
            ),
          ),
          Expanded(
            child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .orderBy('points', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return new Center(child: new CircularProgressIndicator());
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => LeaderboardDetailCard(
                        snapshot.data.documents[index], index),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
