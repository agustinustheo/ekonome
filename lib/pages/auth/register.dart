import 'package:EkonoMe/helpers/navigator_helper.dart';
import 'package:EkonoMe/helpers/validator_helper.dart';
import 'package:EkonoMe/pages/profile/profile.dart';
import 'package:EkonoMe/widgets/alert_widget.dart';
import 'package:EkonoMe/widgets/background_widget.dart';
import 'package:EkonoMe/widgets/button_widget.dart';
import 'package:EkonoMe/widgets/container_widget.dart';
import 'package:EkonoMe/widgets/textfield_widget.dart';
import 'package:EkonoMe/widgets/textlink_widget.dart';
import 'package:EkonoMe/widgets/title_widget.dart';
import 'package:flutter/material.dart';

import '../../helpers/auth_helper.dart';
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

  final registerBloc = RegisterBloc(AuthHelper());

  @override
  Widget build(BuildContext context) {
    return background(container(Form(
        key: _formKey,
        child: Column(children: [
          title('Welcome!'),
          SizedBox(height: 10.0),
          subtitle('Enter your email and password'),
          SizedBox(height: 50.0),
          textField("Enter email",
              prefixIcon: Icon(Icons.email),
              onSaved: (input) => _email = input,
              validator: (input) => ValidatorHelper.validateEmail(input)),
          SizedBox(height: 20.0),
          textField("Enter password",
              isPassword: true,
              prefixIcon: Icon(Icons.lock),
              onSaved: (input) => _password = input,
              onChanged: (input) => _password = input,
              validator: (input) => ValidatorHelper.validatePassword(input)),
          SizedBox(height: 20.0),
          textField("Re-enter password",
              isPassword: true,
              prefixIcon: Icon(Icons.lock),
              validator: (input) =>
                  ValidatorHelper.isPasswordMatch(_password, input)),
          SizedBox(height: 30.0),
          textLink("Have an account? Login here",
              () => NavigatorHelper.pushReplacement(context, LoginPage(), "Login")),
          SizedBox(height: 30.0),
          fullButton(() => signUp(), text: "Register"),
        ]))));
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        // Register user
        this._credentials = new List<String>();
        this._credentials.add(_email);
        this._credentials.add(_password);
        this.registerBloc.credentials.add(_credentials);
        this.registerBloc.register(_credentials);

        // Go to profile page
        NavigatorHelper.pushReplacement(context, ProfilePage(), "Profile");
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
