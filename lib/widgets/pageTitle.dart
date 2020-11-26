import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  PageTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 48.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
