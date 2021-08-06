import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poc_bytebank_flutter/screens/transfer/list_transfer_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransfersList(),
    );
  }
}