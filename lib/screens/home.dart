import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../widgets/bottomNavBar.dart';
import './box.dart';
import './shopList.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, @required this.authService}) : super(key: key);

  final AuthService authService;
  // the authService will be needed for log out

  Widget getScreen(int index) {
    Widget currentScreen;
    switch (index) {
      case 0:
        currentScreen = HomeScreen(authService: authService);
        break;
      case 2:
        currentScreen = BoxScreen();
        break;
      case 1:
        currentScreen = ShopScreen();
        break;
      default:
        currentScreen = HomeScreen(authService: authService);
    }
    return currentScreen;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text('You are logged in!'),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(getScreen: getScreen)
    );
  }
}
