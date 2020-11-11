import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login.dart';

void main() {
  runApp(MyProductsApp());
}

class MyProductsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Set screen orientation to only vertical
    // TODO: Look into whether or not this works on iOS as well
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'MyProducts',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoginScreen(),
      ),
    );
  }
}
