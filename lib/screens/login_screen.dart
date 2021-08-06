import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poc_bytebank_flutter/main.dart';
import 'package:poc_bytebank_flutter/screens/signup_screen.dart';
import 'package:poc_bytebank_flutter/screens/transfer/list_transfer_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _style(context),
    );
  }

  void _gotoSignUpScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SignUp(),
      ),
    );
  }

  Future<void> _loginButtonOnPressed(BuildContext context) async {
    // if (_formKey.currentState!.validate()) {
      /// Login code
      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text;

        Map<String, String> clientMetadata = {
          "email": email,
        };

        final response = await Amplify.Auth.signIn(
          username: email,
          password: password,
          options: CognitoSignInOptions(clientMetadata: clientMetadata),
        );

        if (response.isSignedIn) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TransfersList(),
            ),
          );
        }

      } on AuthException catch (e) {
        _scaffoldKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(e.message),
          ),
        );
      }
    // }
  }

  bool validateEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  Widget _style(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email"),
              controller: _emailController,
              // validator: (value) =>
              // !validateEmail(value!) ? "Email is Invalid" : null,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
              controller: _passwordController,
              // validator: (value) =>
              // value!.isEmpty ? "Password is invalid" : null,
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              child: Text("LOGIN"),
              // onPressed: () => _loginButtonOnPressed(context),
              onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TransfersList();
              })),
              style: ElevatedButton.styleFrom(onPrimary: Theme.of(context).primaryColor),
            ),
            OutlinedButton(
                child: Text("NEW ACCOUNT"),
                onPressed: () => _gotoSignUpScreen(context),
                style: ElevatedButton.styleFrom(onPrimary: Theme.of(context).primaryColor)
            ),
          ],
        ),
      ),
    );
  }
}
