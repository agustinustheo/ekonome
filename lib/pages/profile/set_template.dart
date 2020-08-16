import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/moneytemplate_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class SetTemplatePage extends StatefulWidget {
  @override
  _SetTemplatePageState createState() => _SetTemplatePageState();
}

class _SetTemplatePageState extends State<SetTemplatePage> {
  List<Map> _map;

  @override
  Widget build(BuildContext context) {
    return background(
      container(
        Column(
          children: [
            title('Profile'),
            SizedBox(height: 10.0),
            subtitle('Create your template'),
            SizedBox(height: 20.0),
            moneyTemplate("Blahblah (20%)", (){}),
            SizedBox(height: 10.0),
            addMoneyTemplate((){})
          ]
        )
      )
    );
  }
}
