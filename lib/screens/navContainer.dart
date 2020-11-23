import 'package:flutter/material.dart';
import 'package:products_control/components/boxItems-list.dart';
import '../services/auth.dart';
import '../widgets/bottomNavBar.dart';
import './box.dart';
import './home.dart';
import './checkLists.dart';

class NavContainerScreen extends StatefulWidget {
  NavContainerScreen({Key key}) : super(key: key);

  @override
  _NavContainerScreenState createState() => _NavContainerScreenState();
}

class _NavContainerScreenState extends State<NavContainerScreen> {
  // current index to determine which screen renders
  int _currentIndex = 0;

  // init screens
  static final HomeScreen _homeScreen = HomeScreen();
  static final CheckListsScreen _checkListsScreen = CheckListsScreen();
  static final BoxScreen _boxScreen = BoxScreen();

  final List<Widget> _children = [
    _homeScreen,
    _checkListsScreen,
    _boxScreen,
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _floatingActionButton;

  @override
  Widget build(BuildContext context) {
    if (_currentIndex == 0) {
      _floatingActionButton = null;
    } else if (_currentIndex == 1) {
      _floatingActionButton =
          _checkListsScreen.renderFloatingActionButton(context);
    } else if (_currentIndex == 2) {
      _floatingActionButton = _boxScreen.renderFloatingActionButton(context);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("MyProducts", style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                AuthService().logOut();
              },
              icon: Icon(Icons.exit_to_app, color: Colors.black38),
              label: SizedBox.shrink())
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar:
          BottomNavBar(onTabTapped: onTabTapped, currentIndex: _currentIndex),
      floatingActionButton: _floatingActionButton,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
    );
  }
}
