import 'package:EkonoMe/models/ChartItemModel.dart';
import 'package:EkonoMe/pages/functionality/add_expanse.dart';
import 'package:EkonoMe/pages/functionality/add_fund.dart';
import 'package:EkonoMe/widgets/appbar_widget.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/chart_bar_widget.dart';
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
  List<ChartItemModel> charsData = [
    ChartItemModel(0.5, "Investment", "Rp. 0/120.000"),
    ChartItemModel(0.3, "Debt", "Rp. 0/120.000"),
    ChartItemModel(0.2, "Angsuran", "Rp. 0/120.000")
  ];

  Widget _buildChart() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 20,
          thickness: 2,
        ),
        ...this.charsData.map((e) {
          return ChartBar(e);
        }),
        SizedBox(
          height: 20,
        ),
        Divider(
          height: 20,
          thickness: 2,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

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
            this._buildChart(),
            Column(
              children: <Widget>[
                fullButton(() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddFundPage()));
                }, text: "Add Funds"),
                SizedBox(
                  height: 10,
                ),
                fullButton(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddExpansePage()));
                }, text: "Add Expenses")
              ],
            ),
          ],
        ),
      ),
      appBar: EkonomeAppBar("EkonoMe").getAppBar(),
    );
  }
}
