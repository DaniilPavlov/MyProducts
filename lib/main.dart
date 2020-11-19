import 'package:flutter/material.dart';
import 'package:products_control/screens/authStatus.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';

import 'models/user.dart';

void main() {
  runApp(MyProductsApp());
}

class MyProductsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().currentUser,
        child: MaterialApp(
          title: "MyProducts",
          theme: ThemeData(
              textSelectionHandleColor: Colors.deepPurple,
              textSelectionColor: Colors.deepPurple,
              cursorColor: Colors.deepPurple,
              primaryColor: Colors.deepPurple,
              textTheme: TextTheme(title: TextStyle(color: Colors.white))),
          home: authStatusScreen(),
        ));
  }
}
