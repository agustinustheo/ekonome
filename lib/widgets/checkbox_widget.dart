import 'package:EkonoMe/models/CheckboxItemModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'button_widget.dart';

class CheckboxList extends StatefulWidget {
  final Map<int, String> dictDropdown;

  CheckboxList(this.dictDropdown);

  @override
  _CheckboxListState createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  int selectedItem = 0;
  List<CheckboxItemModel> _selectionList = List<CheckboxItemModel>();
  List<String> _list = List<String>();
  List<String> _labellist = List<String>();

  @override
  void initState() {
    super.initState();
    for (var entry in this.widget.dictDropdown.entries) {
      this._selectionList.add(CheckboxItemModel(entry.key, entry.value));
      this._list.add(entry.value);
      this._labellist.add(entry.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 180,
      
      child: CheckboxGroup(
        onSelected: (List selected) => setState((){
          if (selected.length > 1) {
            selected.removeAt(0);
          } 
          _list = selected;
        }),
        labels: _labellist,
        itemBuilder: (Checkbox cb, Text txt, int i){
          int i=0;
          return Flexible(
              child: Row(
              children: <Widget>[
                cb,
                Expanded(
                  flex: 10,
                  child: txt),
                helpbutton(
                    () => showDescription(txt.data,context),
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