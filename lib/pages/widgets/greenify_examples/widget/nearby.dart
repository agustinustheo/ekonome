import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Nearby extends StatefulWidget {
  Nearby({Key key}) : super(key: key);

  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[_missionTitle(), _missionList()],
      ),
    );
  }

  Widget _missionList() {
    return Container(
      height: 190,
      child: new StreamBuilder(
        stream: Firestore.instance.collection('merchants').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return new Container();
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => _missionItem(snapshot.data.documents[index]),
          );
        }
      ),
    );
  }

  Widget _missionItem(DocumentSnapshot document) {
    return Container(
      width: 190,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(document['image_url'].toString()))),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(63, 63, 63, 0.5),
                      child: Center(
                        child: Text(
                          document['name'].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }

  Widget _missionTitle() {
    return Padding(
        padding: EdgeInsets.only(left: 15, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Nearby",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              textScaleFactor: 1.7,
            ),
            Text("Merchant near you", style: TextStyle(color: Colors.white)),
          ],
        ));
  }
}
