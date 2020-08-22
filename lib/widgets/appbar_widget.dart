import 'package:EkonoMe/helpers/navigator_helper.dart';
import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:EkonoMe/pages/auth/login.dart';
import 'package:EkonoMe/pages/edit_profile/edit_choose_template.dart';
import 'package:EkonoMe/pages/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';

class EkonomeAppBar {
  final String title;
  final BuildContext context;

  EkonomeAppBar(this.title, {this.context});

  AppBar getAppBar() {
    return AppBar(
      title: Text(this.title),
      backgroundColor: Colors.greenAccent[200],
      actions: [
        context != null ? Container(
          padding: EdgeInsets.only(right: 10.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () async{
                  NavigatorHelper.push(context, EditProfilePage(), "EditProfile");
                }
              ),
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () async{
                  NavigatorHelper.push(context, EditChooseTemplatePage(), "EditChooseTemplate");
                }
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async{
                  await SessionHelper.removeUserLogin();
                  NavigatorHelper.pushReplacement(context, LoginPage(), "Login");
                }
              )
            ],
          )
        ) : SizedBox()
      ],
    );
  }
}
