import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greenify/pages/home/event/card/detail.dart';

class EventDetailCard extends StatelessWidget {
  final DocumentSnapshot document;
  EventDetailCard(this.document);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventDetailView(this.document)));
      },
      child: Column(
        children: <Widget>[
          Card(
            color: Color.fromRGBO(63, 63, 63, 1),
            elevation: 5,
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.greenAccent,
                  height: 150,
                  width: 100,
                  child: new Image.asset('assets/graphics/greenify_logo.png'),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        truncateTitle(document['name'].toString()),
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w100,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 170,
                        margin: const EdgeInsets.only(right: 20),
                        child: Text(
                          truncateDesc(document['description'].toString()),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

String truncateDesc(String myString) {
  return (myString.length <= 50) ? myString : '${myString.substring(0, 49)}...';
}

String truncateTitle(String myString) {
  return (myString.length <= 13) ? myString : '${myString.substring(0, 12)}...';
}
