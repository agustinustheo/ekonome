import 'package:EkonoMe/helpers/navigator_helper.dart';
import 'package:EkonoMe/pages/profile/set_template.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/templateitem_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class ChooseTemplatePage extends StatefulWidget {
  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return background(container(Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(child: title('Profile')),
              SizedBox(height: 10.0),
              Center(child: subtitle('Choose or create your template')),
              SizedBox(height: 30.0),
              templateItem("40/30/20/10", context),
              templateItem("30/30/20/20", context),
              templateItem("50/30/20", context),
              SizedBox(height: 40.0),
              fullButton(
                  () => NavigatorHelper.pushReplacement(
                      context, SetTemplatePage()),
                  text: "Create your own template"),
              Center(
                child: smallTitle(
                  "or",
                ),
              ),
              fullButton(() => selectTemplate(), text: "Finsih")
            ]))));
  }

  void selectTemplate() {}
}
