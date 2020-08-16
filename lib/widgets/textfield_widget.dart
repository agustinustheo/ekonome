import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textField(String labelText, {String Function(String) validator, Icon prefixIcon}){
  return SizedBox(
    height: 40.0,
    child: TextFormField(
      decoration: new InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        fillColor: Colors.grey,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
      ),
      validator: validator,
      keyboardType: TextInputType.emailAddress,
    )
  );
}