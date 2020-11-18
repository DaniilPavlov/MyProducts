import 'package:flutter/material.dart';

class CreateCheckListForm extends StatefulWidget {
  CreateCheckListForm({Key key}) : super(key: key);

  @override
  _CreateCheckListFormState createState() => _CreateCheckListFormState();
}

class _CreateCheckListFormState extends State<CreateCheckListForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Создаем новый список',
          style: TextStyle(color: Colors.black, fontSize: 30.0),
        ),
        RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Отмена'),
        ),
      ],
    );
  }
}