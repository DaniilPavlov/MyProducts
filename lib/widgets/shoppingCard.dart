import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingCard extends StatelessWidget {
  ShoppingCard({
    Key key,
    @required this.titleText,
    @required this.subtitleText,
  }) : super(key: key);

  final titleText;
  final subtitleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text(titleText),
              subtitle: Text(subtitleText),
            ),
          ],
        ),
      ),
    );
  }
}