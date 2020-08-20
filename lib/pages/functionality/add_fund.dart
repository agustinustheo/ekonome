import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:EkonoMe/widgets/alert_widget.dart';
import 'package:EkonoMe/widgets/appbar_widget.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/circularprogress_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/dropdown_widget.dart';
import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class AddFundPage extends StatefulWidget {
  AddFundPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddFundPageState createState() => _AddFundPageState();
}

class _AddFundPageState extends State<AddFundPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<int, String> dropDownValues;
  List<dynamic> percentages;
  List<dynamic> currMoney;
  String _id;
  int _money;

  _AddFundPageState() {
    SessionHelper.getUserLogin().then((value) async{
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
        percentages = q.documents[0]["percentages"];
        currMoney = q.documents[0]["funds"];
        _id = q.documents[0].documentID;

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
              title("Hello Timotius"),
              SizedBox(height: 15),
              subtitle("Your balance: Rp. 1.450.000 (Saving)"),
              SizedBox(height: 15),
              smallTitle("Budgeting Rules\n10% Invest\n10% Debt\n50% Everyday Living expenses\n25% Wants, and the remaining 5% on Saving",),
              SizedBox(height: 20),
              Divider(
                height: 10,
                thickness: 2,
              ),
              SizedBox(height: 20),
              Center(
                child: subtitle("Start Saving"),
              ),
              SizedBox(height: 25),
              textField(
                "Amount of money",
                prefixIcon: Icon(Icons.account_balance_wallet),
                onSaved: (input) => _money = int.parse(input)
              ),
              SizedBox(height: 10),
              dropdownListAndButtonWidget(this.dropDownValues, addToCategory),
              SizedBox(height: 5),
              Center(
                child: smallTitle(
                  "or",
                ),
              ),
              SizedBox(height: 5),
              fullButton(() => addToSaving(), text: "Add to saving"),
              SizedBox(height: 10),
              fullButton(() => shareEqually(), text: "Share Equally")
            ],
          ),
        ),
      ),
      appBar: EkonomeAppBar("Add Funds").getAppBar(),
    );
  }

  void shareEqually() async{
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        for(int i = 0; i < percentages.length; i++) currMoney[i] += (percentages[i] * _money / 100);
        FirestoreHelper.updateFirestore("templates", _id, {"funds": currMoney});
        formState.reset();
      } catch (ex) {
        alertError(context, "An exception occured");
      }
    } 
  }

  void addToSaving() async{
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        var q = await FirestoreHelper.getFirestoreDocuments("profile", query: {"=": {"auth_uid": await SessionHelper.getUserLogin()}});
        var currSavings = q.documents[0].data["money"];
        currSavings += _money;

        FirestoreHelper.updateFirestore("profile", q.documents[0].documentID, {"money": currSavings});
        formState.reset();
      } catch (ex) {
        alertError(context, "An exception occured");
      }
    } 
  }

  void addToCategory(int index) async{
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        currMoney[index] += _money;

        FirestoreHelper.updateFirestore("templates", _id, {"funds": currMoney});
        formState.reset();
      } catch (ex) {
        alertError(context, "An exception occured");
      }
    }
  }
}