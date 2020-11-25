import 'package:flutter/material.dart';
import 'file:///C:/Users/lokod/AndroidStudioProjects/products_control/lib/widgets/boxItemsList.dart';
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

    Future<bool> _onExitPressed() {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: Text(
                    "Меняем пользователя?",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        child: Text("Да"),
                        color: Colors.deepPurple,
                        onPressed: () {
                          AuthService().logOut();
                          Navigator.pop(context, true);
                        }),
                    SizedBox(
                      width: 100,
                    ),
                    FlatButton(
                      child: Text("Нет"),
                      color: Colors.deepPurple,
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ]));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("MyProducts", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                _onExitPressed();
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white),
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
