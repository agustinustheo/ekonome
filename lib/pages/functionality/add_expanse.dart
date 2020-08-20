import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:EkonoMe/widgets/appbar_widget.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/circularprogress_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/dropdown_widget.dart';
import 'package:EkonoMe/widgets/profile_widget.dart';
import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class AddExpansePage extends StatefulWidget {
  AddExpansePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddExpansePageState createState() => _AddExpansePageState();
}

class _AddExpansePageState extends State<AddExpansePage> {
  Map<int, String> dropDownValues;
  int _money;
  String authUid;

  _AddExpansePageState() {
    SessionHelper.getUserLogin().then((value) async{
      authUid = value;
      var q = await FirestoreHelper.getFirestoreDocuments(
        "templates", 
        query: {
          "=": {
            "auth_uid": value
          }
        }
      );

      setState(() {
        var data = q.documents[0]['titles'];
        dropDownValues = new Map<int, String>();
        for(int i=0; i<data.length; i++){
          dropDownValues[i] = data[i];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(dropDownValues == null) return background(circularProgress());
    return background(
      container(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            fullProfile(authUid),
            Divider(
              height: 10,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            textField(
              "Amount of money",
              prefixIcon: Icon(Icons.account_balance_wallet),
            ),
            SizedBox(
              height: 10,
            ),
            dropdownListAndButtonWidget(this.dropDownValues, () => {}),
          ],
        ),
      ),
      appBar: EkonomeAppBar("Add Expenses").getAppBar(),
    );
  }
}
