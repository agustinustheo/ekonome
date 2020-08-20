import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/moneytemplate_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class SetTemplatePage extends StatefulWidget {
  @override
  _SetTemplatePageState createState() => _SetTemplatePageState();
}

class _SetTemplatePageState extends State<SetTemplatePage> {
  // Initialize widget lists
  List<Widget> _moneyTemplates = new List<Widget>();
  List<String> _titleList = new List<String>();
  List<int> _percentageList = new List<int>();

  // Set initial state
  _SetTemplatePageState() {
    SessionHelper.getUserLogin().then((authUid) => {
          FirestoreHelper.getFirestoreDocuments("templates", query: {
            "=": {"auth_uid": authUid}
          }).then((value) {
            _titleList = value.documents.map<List<String>>((doc) {
              return List<String>.from(doc['titles']);
            }).first;

            _percentageList = value.documents.map<List<int>>((doc) {
              return List<int>.from(doc['percentages']);
            }).first;

            setState(() {
              for (int i = 0; i < _titleList.length; i++) {
                _moneyTemplates.add(moneyTemplate(
                    _titleList[i], _percentageList[i], removeMoneyTemplate));
              }
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return background(container(Column(children: [
      title('Profile'),
      SizedBox(height: 10.0),
      subtitle('Create your template'),
      SizedBox(height: 20.0),
      _moneyTemplates.length > 0
          ? Column(children: _moneyTemplates)
          : SizedBox(),
      addMoneyTemplate(addNewMoneyTemplate),
      fullButton(() => saveTemplate(), text: "Save")
    ])));
  }

  void addNewMoneyTemplate(String _title, int _percentage) {
    setState(() {
      if (_title != null && _percentage != null) {
        _moneyTemplates
            .add(moneyTemplate(_title, _percentage, removeMoneyTemplate));
        _titleList.add(_title);
        _percentageList.add(_percentage);
      }
    });
  }

  void removeMoneyTemplate(UniqueKey uk, String title, int percentage) {
    setState(() {
      _moneyTemplates.removeWhere((widget) => widget.key == uk);
      _titleList.removeWhere((curr) => curr == title);
      _percentageList.removeWhere((curr) => curr == percentage);
    });
  }

  void saveTemplate() async {
    FirestoreHelper.insertToFirestore("templates", {
      "auth_uid": await SessionHelper.getUserLogin(),
      "titles": _titleList,
      "percentages": _percentageList
    });
  }
}
