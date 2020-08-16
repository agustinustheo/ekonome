import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

Widget addMoneyTemplate(Function function){
  return Row(
    children: [
      Expanded(flex: 6, child: textField('Name')),
      SizedBox(width: 10.0),
      Expanded(flex: 2, child: textField('%')),
      SizedBox(width: 10.0),
      Expanded(
        flex: 2,
        child: button(
          function,
          icon: Icon(Icons.add_box), 
          radius: 5.0
        )
      )
    ],
  );
}

Widget moneyTemplate(String text, Function function){
  return Row(
    children: [
      Expanded(flex: 8, child: textField(text)),
      SizedBox(width: 10.0),
      Expanded(
        flex: 2,
        child: button(
          function,
          icon: Icon(Icons.indeterminate_check_box), 
          radius: 5.0
        )
      )
    ],
  );
}