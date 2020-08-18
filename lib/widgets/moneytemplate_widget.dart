import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

Widget addMoneyTemplate(Function(String, int) addWidget){
  // Initialize controller
  var _titleController = TextEditingController();
  var _percentageController = TextEditingController();

  return Row(
    children: [
      Expanded(
        flex: 6, 
        child: textField(
          'Title', 
          controller: _titleController
        )
      ),
      SizedBox(width: 10.0),
      Expanded(
        flex: 2, 
        child: textField(
          '%', 
          controller: _percentageController
        )
      ),
      SizedBox(width: 10.0),
      Expanded(
        flex: 2,
        child: button(
          () => addWidget(_titleController.text, int.parse(_percentageController.text)),
          icon: Icon(Icons.add_box), 
          radius: 5.0
        )
      )
    ]
  );
}

Widget moneyTemplate(String title, int percentage, Function(UniqueKey, String, int) function){
  var uk = UniqueKey();
  return Column(
    key: uk,
    children: [
      Row(
        children: [
          Expanded(flex: 8, child: textField(title + " (" + percentage.toString() + "%)")),
          SizedBox(width: 10.0),
          Expanded(
            flex: 2,
            child: button(
              () => function(uk, title, percentage),
              icon: Icon(Icons.indeterminate_check_box), 
              radius: 5.0
            )
          )
        ],
      ),
      SizedBox(height: 10.0),
    ]
  );
}