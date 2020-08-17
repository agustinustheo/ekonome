import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:EkonoMe/helpers/navigator_helper.dart';

void alertSuccess(BuildContext context, String message){
  Alert(
    context: context,
    type: AlertType.error,
    title: "Success",
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => NavigatorHelper.pop(context),
        width: 120,
      )
    ],
  ).show();
}

void alertError(BuildContext context, String message){
  Alert(
    context: context,
    type: AlertType.error,
    title: "Error",
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}