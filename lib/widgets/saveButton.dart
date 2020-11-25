import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function onPressed;

  SaveButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(0.0),
          side: BorderSide(color: Colors.deepPurple)),
      onPressed: () {
        onPressed();
      },
      color: Colors.deepPurple,
      textColor: Colors.white,
      child: Icon(Icons.save),
    );
  }
}
