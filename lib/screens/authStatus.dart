import 'package:flutter/material.dart';
import 'package:products_control/screens/navContainer.dart';
import 'package:provider/provider.dart';
import 'package:products_control/models/user.dart';
import 'login.dart';

class AuthStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final bool isLogged = user != null;
    return isLogged ? NavContainerScreen() : LoginScreen();
  }
}
