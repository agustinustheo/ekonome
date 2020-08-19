import 'package:EkonoMe/models/DropdownItem.dart';
import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  final Map<int, String> dictDropdown;

  DropDownList(this.dictDropdown);

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  int selectedItem = 0;
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
        child: DropdownButton<int>(
          isExpanded: true,
          hint: Text(
            "Choose Expense Target",
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          value: this._selectionList[this.selectedItem].id,
          onChanged: (int newVal) {
            setState(() {
              this.selectedItem = newVal;
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
