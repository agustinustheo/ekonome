import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'button_widget.dart';

class RadioButtonList extends StatefulWidget {
  final List<String> list;
  final void Function(String) function;

  RadioButtonList(this.list, this.function);

  @override
  _RadioButtonListState createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 180,
      
      child: RadioButtonGroup(
        onSelected: this.widget.function,
        labels: this.widget.list,
        itemBuilder: (Radio cb, Text txt, int i){
          return Flexible(
              child: Row(
              children: <Widget>[
                cb,
                Expanded(
                  flex: 10,
                  child: txt),
                helpbutton(
                    () => showDescription(txt.data, context),
                    icon: Icon(Icons.help), 
                    radius: 10.0
                )
              ],
            )
          );
        },
      )
    );
  }
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
                Text('Hey'),
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