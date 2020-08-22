import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:EkonoMe/widgets/alert_widget.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<int, String> dropDownValues;
  List<dynamic> currMoney;
  String _id, authUid, _profileId;
  int _money, _savings;

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
      
      var profile = await FirestoreHelper.getFirestoreDocuments(
        "profile", 
        query: {
          "=": {
            "auth_uid": value
          }
        }
      );

      setState(() {
        var data = q.documents[0]['titles'];
        currMoney = q.documents[0]["funds"];
        _id = q.documents[0].documentID;

        _savings = profile.documents[0]['money'];
        _profileId = profile.documents[0].documentID;
        
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
        Form(
          key: _formKey,
          child: Column(
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
                onSaved: (input) => _money = int.parse(input)
              ),
              SizedBox(
                height: 10,
              ),
              dropdownListAndButtonWidget(this.dropDownValues, addToCategory),
            ],
          ),
        )
      ),
      appBar: EkonomeAppBar("Add Expenses").getAppBar(),
    );
  }

  void addToCategory(int index) async{
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        int newSavings = _savings - _money;
        if(newSavings < 0) throw ArgumentError("You do not have sufficient savings.");
        currMoney[index] += _money;

        FirestoreHelper.updateFirestore("templates", _id, {"funds": currMoney});
        FirestoreHelper.updateFirestore("profile", _profileId, {"money": newSavings});
        formState.reset();
      } catch (ex) {
        if(ex is ArgumentError) alertError(context, ex.message);
        else alertError(context, "An exception occured");
      }
    }
  }
}
