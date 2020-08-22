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
        itemBuilder: (Radio cb, Text txt, int i) {
          return Flexible(
            child: Row(
              children: <Widget>[
                cb,
                Expanded(flex: 10, child: txt),
                helpbutton(() => showDescription(txt.data, context),
                    icon: Icon(Icons.help), radius: 10.0)
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildExplanation(String title) {
  return Center(
    child: title == "40/30/20"
        ? Text(
            "40 percent of your income are allocated to your daily needs expenses, \n30 percent of it distributed as wants,\nand the remaining 20 percent are considered as savings.")
        : title == "50/40/10"
            ? Text(
                "50 percent of your income are allocated to daily needs expenses, \n40 percent to savings,\nand the remaining 10 percent to debt.")
            : Text(
                "30 percent of your income to expenses,\n20 percent to debt,\n20 percent to savings,\nand the remaining 20 percent to giving."),
  );
}

Future<void> showDescription(String title, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("The $title rule"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              _buildExplanation(title),
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
