import 'package:EkonoMe/models/DropdownItem.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/circularprogress_widget.dart';
import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  final Map<dynamic, dynamic> dictDropdown;
  dynamic selectedItem = 0;

  DropDownList(this.dictDropdown);

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  List<DropdownItemModel> _selectionList = List<DropdownItemModel>();

  @override
  void initState() {
    super.initState();
    for (var entry in this.widget.dictDropdown.entries) {
      this._selectionList.add(DropdownItemModel(entry.key, entry.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          isExpanded: true,
          hint: Text(
            "Choose Expense Target",
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          value: this._selectionList[this.widget.selectedItem].id,
          onChanged: (dynamic newVal) {
            setState(() {
              this.widget.selectedItem = newVal;
            });
          },
          items: [
            ...this._selectionList.map((element) {
              return DropdownMenuItem(
                value: element.id,
                child: Text(
                  element.name,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget dropdownListAndButtonWidget(Map<dynamic, dynamic> dropdownValues, Function function){
  var ddl = DropDownList(dropdownValues);
  if(dropdownValues == null) return circularProgress();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Flexible(
        flex: 2,
        child: ddl,
      ),
      Flexible(
        flex: 1,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: fullButton(() => function(ddl.selectedItem), text: "Add"),
        ),
      ),
    ],
  );
}
