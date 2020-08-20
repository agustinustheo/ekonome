import 'package:EkonoMe/models/ChartItemModel.dart';
import 'package:EkonoMe/pages/functionality/add_expanse.dart';
import 'package:EkonoMe/pages/functionality/add_fund.dart';
import 'package:EkonoMe/widgets/appbar_widget.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/chart_bar_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
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
    ChartItemModel(0.2, "Angsuran", "Rp. 0/120.000"),
    ChartItemModel(0.5, "Investment", "Rp. 0/120.000"),
    ChartItemModel(0.3, "Debt", "Rp. 0/120.000"),
    ChartItemModel(0.2, "Angsuran", "Rp. 0/120.000")
  ];

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        border: Border.all(
          width: .5,
          color: Colors.green,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 215,
      width: double.infinity,
      child: child,
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
            SizedBox(
              height: 20,
            ),
            this._buildContainer(
              ListView.builder(
                itemBuilder: (context, index) =>
                    ChartBar(this.charsData[index]),
                itemCount: this.charsData.length,
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
