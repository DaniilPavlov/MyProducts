import 'package:flutter/cupertino.dart';

class BoxScreen extends StatelessWidget {

  @override
  Widget build (BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: Text('Мои товары'),
        ),
      ),
    );
  }
} 