import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:EkonoMe/models/ChartItemModel.dart';
import 'package:EkonoMe/pages/functionality/add_expanse.dart';
import 'package:EkonoMe/pages/functionality/add_fund.dart';
import 'package:EkonoMe/widgets/appbar_widget.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/chart_bar_widget.dart';
import 'package:EkonoMe/widgets/circularprogress_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChartItemModel> charsData = [
    ChartItemModel(0.0, "Investment", "Rp. 0/120.000"),
    ChartItemModel(0.1, "Debt", "Rp. 0/120.000"),
    ChartItemModel(0.2, "Angsuran", "Rp. 0/120.000"),
    ChartItemModel(0.3, "Beli Kerupuk", "Rp. 0/120.000"),
    ChartItemModel(0.4, "Makan Alpukat Bersama", "Rp. 0/120.000"),
    ChartItemModel(0.5, "Beli Gelas", "Rp. 0/120.000"),
    ChartItemModel(0.6, "Sewa Kamar", "Rp. 0/120.000"),
    ChartItemModel(0.7, "Beli Dompet", "Rp. 0/120.000"),
    ChartItemModel(0.8, "Jual Motor", "Rp. 0/120.000"),
    ChartItemModel(0.9, "Hambur hamburin", "Rp. 0/120.000"),
    ChartItemModel(1.0, "Pesta", "Rp. 0/120.000")
  ];
  String authUid = "";

  _HomePageState() {
    SessionHelper.getUserLogin().then((value) async{
      setState(() {
        authUid = value;
      });
    });
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     spreadRadius: 1,
        //     blurRadius: 1,
        //   ),
        // ],
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
    if(authUid == "") return background(circularProgress());
    return background(
      container(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            fullProfile(authUid),
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
