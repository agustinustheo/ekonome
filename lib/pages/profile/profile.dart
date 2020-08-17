import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate;
  var _dateTimeController = TextEditingController();

  // Set initial state
  _ProfilePageState() {
    _dateTimeController.text = selectedDate == null ? "" : "${selectedDate.toLocal()}".split(' ')[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate??DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateTimeController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return background(
      container(
        Column(
          children: [
            title('Profile'),
            SizedBox(height: 10.0),
            subtitle('Create your template'),
            SizedBox(height: 50.0),
            textField(
              "Enter fullname",
              prefixIcon: Icon(Icons.person)
            ),
            SizedBox(height: 20.0),
            textField(
              "Amount of money",
              prefixIcon: Icon(Icons.attach_money)
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
            fullButton((){}, text: "Next"),
          ]
        )
      )
    );
  }
}
