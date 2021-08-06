import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:poc_bytebank_flutter/screens/login_screen.dart';
import '../amplifyconfiguration.dart';
import '../widgets/login.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {

  final amplify = Amplify;
  bool _amplifyConfigured = false;

  @override
  void initState(){
    super.initState();
    _amplifyConfigure();
  }

  void _amplifyConfigure() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();

    try {
      amplify.addPlugins([auth, analytics]);
      await amplify.configure(amplifyconfig);
      print('Successfully configured Amplify');
      setState(() {
        _amplifyConfigured = true;
      });
    } catch(e) {
      print('Could not configure Amplify');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: _amplifyConfigured ? LoginScreen() : CircularProgressIndicator(),
      ),
    );
  }
}
