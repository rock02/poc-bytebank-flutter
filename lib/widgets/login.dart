import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Future<String> _onLogin(BuildContext context, LoginData data) async {
    // await Future.delayed(Duration(seconds: 1));
    print(data);
    throw Exception('Error from Exception');
  }

  Future<String> _onSignup(BuildContext context, LoginData data) async {
    try {

      Map<String, String> userAttributes = {
        'email': data.name,
        'preferred_username': data.name,
        "phone_number": "+5583991949559"
      };

      await Amplify.Auth.signUp(
          username: data.name,
          password: data.password,
          options: CognitoSignUpOptions(userAttributes: userAttributes),
      );

    }on AuthException catch(e){
      return 'There was a problem signing up.';
    }
    throw Exception('Error from Exception');
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "Byte Bank",
      onLogin: (LoginData data) => _onLogin(context, data),
      onRecoverPassword: (_) => Future.value(''),
      onSignup: (LoginData data) => _onSignup(context, data),
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor
      ),
      onSubmitAnimationCompleted: (){},
    );
  }
}
