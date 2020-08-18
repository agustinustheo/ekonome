import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:EkonoMe/widgets/alert_widget.dart';
import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Initialize input variable
  String _fullName;
  int _money;
  DateTime _selectedDate;

  // Initialize controller
  var _dateTimeController = TextEditingController();

  // Set initial state
  _ProfilePageState() {
    _dateTimeController.text = _selectedDate == null ? "" : "${_selectedDate.toLocal()}".split(' ')[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate??DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateTimeController.text = "${_selectedDate.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return background(
      container(
        Form(
          key: _formKey,
          child: Column(
            children: [
              title('Profile'),
              SizedBox(height: 10.0),
              subtitle('Create your template'),
              SizedBox(height: 50.0),
              textField(
                "Enter fullname",
                prefixIcon: Icon(Icons.person),
                onSaved: (input) => _fullName = input
              ),
              SizedBox(height: 20.0),
              textField(
                "Amount of money",
                prefixIcon: Icon(Icons.attach_money),
                onSaved: (input) => _money = int.parse(input)
              ),
              SizedBox(height: 20.0),
              textField(
                "Reset date",
                prefixIcon: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
                readOnly: true,
                controller: _dateTimeController
              ),
              SizedBox(height: 40.0),
              fullButton(() => saveProfile(), text: "Next"),
            ]
          )
        )
      )
    );
  }

  Future<void> saveProfile() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        // Save data
        FirestoreHelper.insertToFirestore("profile", {
          "auth_uid": await SessionHelper.getUserLogin(),
          "fullname": _fullName,
          "money": _money,
          "datetime": _selectedDate
        });
      }
      catch(insertError){
        alertError(context, "An exception occured");
      }
    }
  }
}
