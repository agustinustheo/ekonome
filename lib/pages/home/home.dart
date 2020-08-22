import 'package:EkonoMe/helpers/firestore_helper.dart';
import 'package:EkonoMe/helpers/navigator_helper.dart';
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
import 'package:EkonoMe/widgets/stream_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChartItemModel> charsData = new List<ChartItemModel>();
  String authUid = "";

  _HomePageState() {
    SessionHelper.getUserLogin().then((value){
      setState((){
        authUid = value;
      });
    });
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
              chartStream({"=": {"auth_uid": authUid}})
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                fullButton(() => NavigatorHelper.push(context, AddFundPage(), "Fund"), text: "Add Funds"),
                SizedBox(height: 10),
                fullButton(() => NavigatorHelper.push(context, AddExpansePage(), "Expense"), text: "Add Expenses")
              ],
            ),
          ],
        ),
      ),
      appBar: EkonomeAppBar("EkonoMe", context: context).getAppBar(),
    );
  }
}
