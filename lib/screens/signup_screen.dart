import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'email_confirmation_screen.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                validator: (value) => value!.isEmpty
                    ? "Password is invalid"
                    : value.length < 9
                    ? "Password must contain at least 8 characters"
                    : null,
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  child: Text("CREATE ACCOUNT"),
                  onPressed: () => _createAccountOnPressed(context),
                  style: ElevatedButton.styleFrom(onPrimary: Theme.of(context).primaryColor)
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _gotToEmailConfirmationScreen(BuildContext context, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EmailConfirmationScreen(email: email),
      ),
    );
  }

  Future<void> _createAccountOnPressed(BuildContext context) async {

    // if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      Map<String, String> userAttributes = {
        "email": email,
      };

      try {
        final result = await Amplify.Auth.signUp(

          username: email,
          password: password,
          options: CognitoSignUpOptions(userAttributes: userAttributes),
        );
        if (result.isSignUpComplete) {
          _gotToEmailConfirmationScreen(context, email);
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
}
