import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/helpers/navigator_helper.dart';
import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:EkonoMe/pages/auth/login.dart';
import 'package:EkonoMe/pages/profile/set_template.dart';
import 'package:EkonoMe/widgets/alert_widget.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/radiobutton_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class ChooseTemplatePage extends StatefulWidget {
  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> radioButtonValue = [
    "40/30/20",
    "50/40/10",
    "30/30/20/20"
  ];
  String _selected, _authUid;

  _ChooseTemplatePageState(){
    SessionHelper.getTemp().then((value){
      _authUid = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return background(container(Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(child: title('Profile')),
              SizedBox(height: 10.0),
              Center(child: subtitle('Choose or create your template')),
              SizedBox(height: 30.0),
              Row(
                children: <Widget>[
                  Flexible(flex: 6, child: RadioButtonList(radioButtonValue, (String selected) => setState((){
                      _selected = selected;
                    }))
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              fullButton(
                  () => NavigatorHelper.pushReplacement(
                      context, SetTemplatePage(), "SetTemplate"),
                  text: "Create your own template"),
              Center(
                child: smallTitle(
                  "or",
                ),
              ),
              fullButton(() => selectTemplate(), text: "Finish")
            ]))));
  }

  void selectTemplate() {
    List<String> _titles;
    List<int> _percentages;
    List<int> _funds;
    List<int> _targets;

    if(_selected == "40/30/20"){
      _titles = ["Expenses in Daily Living","Investing","Debt"];
      _percentages = [40,30,20];
      _funds = [0,0,0];
      _targets = [0,0,0];
    }
    else if(_selected == "50/40/10"){
      _titles = ["Expenses in Daily Living","Investing"];
      _percentages = [50,40];
      _funds = [0,0];
      _targets = [0,0];
    }
    else if(_selected == "30/30/20/20"){
      _titles = ["Expenses in Daily Living","Investing","Debt"];
      _percentages = [30,30,20];
      _funds = [0,0,0];
      _targets = [0,0,0];
    }

    int percentages = 0;
    for(var x in _percentages) percentages += x;
    if(percentages <= 99 && percentages > 0){
      alertInfo(context, "Your savings would be " + (100-percentages).toString() + "% of your income.\n\nPress OK to save and continue", function: (){
        FirestoreHelper.insertToFirestore("templates", {
          "auth_uid": _authUid,
          "titles": _titles,
          "percentages": _percentages,
          "funds": _funds,
          "targets": _targets
        });

        alertSuccess(context, "Succesfully create template!", function:(){
          NavigatorHelper.pushReplacement(context, LoginPage(), "Login");
        });
      });
    }
  }
}
