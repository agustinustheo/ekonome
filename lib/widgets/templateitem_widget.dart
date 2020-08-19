import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

Widget templateItem(String title, BuildContext context){
  var uk = UniqueKey();
  return Column(
    key: uk,
    children: [
      Row(
        children: [
          Expanded(flex: 8, child: textField(title)),
          SizedBox(width: 10.0),
          Expanded(
            flex: 2,
            child: button(
              () => showDescription(title,context),
              icon: Icon(Icons.help), 
              radius: 5.0
            )
          )
        ],
      ),
      SizedBox(height: 10.0),
    ]
  );
}

 Future<void> showDescription(String title, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            button(() => Navigator.of(context).pop(), text: "Okay")
          ],
        );
      },
    );
  }