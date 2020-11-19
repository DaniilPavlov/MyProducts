import 'package:flutter/material.dart';

class CreateCheckListForm extends StatefulWidget {
  CreateCheckListForm({Key key}) : super(key: key);

  @override
  _CreateCheckListFormState createState() => _CreateCheckListFormState();
}

class _CreateCheckListFormState extends State<CreateCheckListForm> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = '(Коробка) Моя коробка';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(
          20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Добавляем новый список',
              style: TextStyle(
                color: Colors.black,
                fontSize: 42.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 30.0,
              ),
              child: TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  labelText: 'Название',
                  hintText: 'Продукты для завтрака',
                  labelStyle: TextStyle(
                    fontSize: 26.0,
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Пожалуйста введите название';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                bottom: 30.0,
              ),
              child: TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  hintText: 'Только полезные продукты',
                  labelStyle: TextStyle(
                    fontSize: 26.0,
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Пожалуйста введите описание';
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 120.0,
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // Process data
                      }
                    },
                    child: Text(
                      'Добавить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                      ),
                    ),
                    color: Colors.lightBlue,
                  ),
                ),
                ButtonTheme(
                  minWidth: 120.0,
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Отмена',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                      ),
                    ),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
