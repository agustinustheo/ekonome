import 'package:EkonoMe/helpers/auth_helper.dart';
import 'package:EkonoMe/helpers/navigator_helper.dart';
import 'package:EkonoMe/helpers/session_helper.dart';
import 'package:EkonoMe/pages/auth/register.dart';
import 'package:EkonoMe/Bloc/auth/login_bloc.dart';
import 'package:EkonoMe/pages/home/home.dart';
import 'package:EkonoMe/widgets/alert_widget.dart';
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

  final loginBloc = LoginBloc(AuthHelper());

  _LoginPageState(){
    SessionHelper.checkSession().then((value) => NavigatorHelper.pushReplacement(context, HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return background(container(Form(
        key: _formKey,
        child: Column(children: [
          title('Welcome!'),
          SizedBox(height: 10.0),
          subtitle('Enter your email and password'),
          SizedBox(height: 50.0),
          textField("Enter email", prefixIcon: Icon(Icons.email), onSaved: (input) => _email = input),
          SizedBox(height: 20.0),
          textField("Enter password",
              isPassword: true, prefixIcon: Icon(Icons.lock), onSaved: (input) => _password = input),
          SizedBox(height: 30.0),
          textLink("Don't have an account? Register here",
              () => NavigatorHelper.pushReplacement(context, RegisterPage())),
          SizedBox(height: 30.0),
          fullButton(() => signIn(), text: "Login"),
        ]))));
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        // Register user
        this._credentials = new List<String>();
        this._credentials.add(_email);
        this._credentials.add(_password);
        this.loginBloc.credentials.add(_credentials);
        await this.loginBloc.login(this._credentials);

        // Go to login page
        NavigatorHelper.pushReplacement(context, HomePage());
      } catch (signUpError) {
        if (signUpError is String) {
          alertError(context, signUpError);
        } else {
          alertError(context, "An exception occured");
        }
      }
    }
  }
}
