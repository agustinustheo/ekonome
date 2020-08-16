import '../widget/event_detail_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 35, bottom: 5),
                child: Container(
                  height: 65,
                  child: new Image.asset('assets/graphics/events.png'),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height - 90,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: new StreamBuilder(
                      stream:
                          Firestore.instance.collection('events').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return new Container();
                        return ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) =>
                              EventDetailCard(snapshot.data.documents[index]),
                        );
                      })),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
