import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key key, @required this.getScreen}) : super(key: key);

  final Function getScreen;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _navOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Check list',
      style: optionStyle,
    ),
    Text(
      'Index 2: Box',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index, BuildContext context) {
    Widget incomingScreen = widget.getScreen(index);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return incomingScreen;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text('Check list')),
        BottomNavigationBarItem(icon: Icon(Icons.kitchen), title: Text('Box'))
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: (int index) => _onItemTapped(index, context),
    );
  }
}
