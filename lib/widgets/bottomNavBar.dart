import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar(
      {Key key, @required this.onTabTapped, @required this.currentIndex})
      : super(key: key);

  final Function onTabTapped;
  final int currentIndex;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Главная')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('Списки покупок')),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox), title: Text('Моя коробка'))
        ],
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: widget.onTabTapped,
        type: BottomNavigationBarType.fixed);
  }
}
