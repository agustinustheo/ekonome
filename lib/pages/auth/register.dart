import 'package:EkonoMe/services/navigator_service.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/space_widget.dart';
import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:EkonoMe/widgets/textlink_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../Bloc/auth/register_bloc.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email, _password;

  List<String> _credentials;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final registerBloc = RegisterBloc(AuthService());

  void _feedBloc() {
    this._credentials.add(_email);
    this._credentials.add(_password);
    this.registerBloc.credentials.add(_credentials);
  }

  @override
  Widget build(BuildContext context) {
    return background(
      container(
        Column(
          children: [
            title('Welcome!'),
            space(10.0),
            subtitle('Enter your email and password'),
            space(50.0),
            textField(
              "Enter email",
              prefixIcon: Icon(Icons.email)
            ),
            space(20.0),
            textField(
              "Enter password",
              prefixIcon: Icon(Icons.lock)
            ),
            space(20.0),
            textField(
              "Re-enter password",
              prefixIcon: Icon(Icons.lock)
            ),
            space(30.0),
            textLink(
              "Have an account? Login here",
              () => NavigatorService.pushReplace(context, LoginPage())
            ),
            space(30.0),
            fullButton("Register", (){}),
          ]
        )
      )
    );
  }
}
