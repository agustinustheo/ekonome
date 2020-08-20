import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/widgets/circularprogress_widget.dart';
import 'package:EkonoMe/widgets/stream_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget fullProfile(String authUid){
  return Column(children: [profileStream(authUid), templateStream(authUid)]);
}

class Profile extends StatelessWidget {
  final DocumentSnapshot profileDocument;

  Profile(this.profileDocument);

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          title("Hello " + this.profileDocument["fullname"]),
          SizedBox(height: 15),
          subtitle("Your balance: Rp. " + this.profileDocument["money"].toString() + " (Saving)"),
          SizedBox(height: 15)
        ]
      );
  }
}

class Template extends StatelessWidget {
  final DocumentSnapshot templateDocument;
  List<Widget> rules = new List<Widget>();

  Template(this.templateDocument);

  @override
  Widget build(BuildContext context) {
      dynamic savePercent = 100;
      for(int i = 0; i < templateDocument["percentages"].length; i++){
        savePercent -= templateDocument["percentages"][i];

        if(i == templateDocument["percentages"].length - 1)
          rules.add(smallTitle(templateDocument["percentages"][i].toString() + "% " + templateDocument["titles"][i].toString() + ", and the remaining " + savePercent.toString() + "% on Saving"));
        else
          rules.add(smallTitle(templateDocument["percentages"][i].toString() + "% " + templateDocument["titles"][i].toString()));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          smallTitle("Budgeting Rules"),
          rules.length == 0 ? circularProgress() : Column(children: rules, crossAxisAlignment: CrossAxisAlignment.start),
          SizedBox(height: 10),
        ]
      );
  }
}