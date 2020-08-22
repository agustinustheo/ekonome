import 'package:EkonoMe/helpers/navigator_helper.dart';
import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:EkonoMe/pages/home/home.dart';
import 'package:EkonoMe/widgets/appbar_widget.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:EkonoMe/widgets/alert_widget.dart';
import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Initialize input variable
  String _fullName, _id, _authUid;
  int _money;
  DateTime _selectedDate;

  // Initialize controller
  var _fullnameController = TextEditingController();
  var _moneyController = TextEditingController();
  var _dateTimeController = TextEditingController();
  Timestamp asd = new Timestamp(1, 1);

  // Set initial state
  _EditProfilePageState() {
    SessionHelper.getUserLogin().then((value) async{
      var data = await FirestoreHelper.getFirestoreDocuments("profile", query: {"=": {"auth_uid": value}});
      _fullnameController.text = data.documents[0].data["fullname"];
      _moneyController.text = data.documents[0].data["money"].toString();
      _selectedDate = data.documents[0].data["datetime"].toDate();
      _dateTimeController.text = "${_selectedDate.toLocal()}".split(' ')[0];

      _authUid = value;
      _id = data.documents[0].documentID;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
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
    return background(container(Form(
        key: _formKey,
        child: Column(children: [
          title('Profile'),
          SizedBox(height: 10.0),
          subtitle('Edit your template'),
          SizedBox(height: 50.0),
          textField("Enter fullname",
              prefixIcon: Icon(Icons.person),
              onSaved: (input) => _fullName = input,
              controller: _fullnameController),
          SizedBox(height: 20.0),
          textField("Amount of money",
              prefixIcon: Icon(Icons.attach_money),
              onSaved: (input) => _money = int.parse(input),
              controller: _moneyController),
          SizedBox(height: 20.0),
          textField("Reset date",
              prefixIcon: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
              readOnly: true,
              controller: _dateTimeController),
          SizedBox(height: 40.0),
          fullButton(() => saveProfile(), text: "Save"),
        ]))), appBar: EkonomeAppBar("Edit Profile").getAppBar());
  }

  Future<void> saveProfile() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        // Save data
        FirestoreHelper.updateFirestore("profile", _id, {
          "auth_uid": _authUid,
          "fullname": _fullName,
          "money": _money,
          "datetime": _selectedDate
        });

        alertSuccess(context, "Succesfully save profile!");
      } catch (insertError) {
        alertError(context, "An exception occured");
      }
    }
  }
}
