import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/dropdown_widget.dart';
import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<int, String> dropDownValues = {
    0: "Investment",
    1: "Saving",
    2: "Everyday Living",
  };

  @override
  Widget build(BuildContext context) {
    return background(
      container(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Hello Timotius",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Your balance: Rp. 1.450.000 (Saving)",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Budgeting Rules\n10% Invest\n10% Debt\n50% Everyday Living expenses\n25% Wants, and the remaining 5% on Saving",
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 10,
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: subtitle(
                "Start Saving",
              ),
            ),
            SizedBox(
              height: 25,
            ),
            textField(
              "Amount of money",
              prefixIcon: Icon(Icons.account_balance_wallet),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: DropDownList(this.dropDownValues),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: fullButton(() {}, text: "Add"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
