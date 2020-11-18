import 'package:flutter/material.dart';

class CreateBoxItemForm extends StatefulWidget {
  CreateBoxItemForm({Key key}) : super(key: key);

  @override
  _CreateBoxItemFormState createState() => _CreateBoxItemFormState();
}

class _CreateBoxItemFormState extends State<CreateBoxItemForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Создаем новый объект',
          style: TextStyle(color: Colors.black, fontSize: 30.0),
        ),
        RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('отмена'),
        ),
      ],
    );
  }
}