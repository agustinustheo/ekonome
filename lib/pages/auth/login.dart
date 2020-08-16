import 'package:EkonoMe/pages/auth/register.dart';
import 'package:EkonoMe/services/auth_service.dart';
import 'package:EkonoMe/Bloc/auth/login_bloc.dart';
import 'package:EkonoMe/services/navigator_service.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:EkonoMe/widgets/textlink_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;

  List<String> _credentials;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final loginBloc = LoginBloc(AuthService());

  void _feedBloc() {
    this._credentials.add(_email);
    this._credentials.add(_password);
    this.loginBloc.credentials.add(_credentials);
  }

  @override
  Widget build(BuildContext context) {
    return background(
      container(
        Column(
          children: [
            title('Welcome!'),
            SizedBox(height: 10.0),
            subtitle('Enter your email and password'),
            SizedBox(height: 50.0),
            textField(
              "Enter email",
              prefixIcon: Icon(Icons.email)
            ),
            SizedBox(height: 20.0),
            textField(
              "Enter password",
              prefixIcon: Icon(Icons.lock)
            ),
            SizedBox(height: 30.0),
            textLink(
              "Don't have an account? Register here",
              () => NavigatorService.pushReplacement(context, RegisterPage())
            ),
            SizedBox(height: 30.0),
            fullButton((){}, text: "Login"),
          ]
        )
      )
    );
  }
}
