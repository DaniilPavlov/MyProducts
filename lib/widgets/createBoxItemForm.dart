import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:products_control/models/data.dart';
import 'package:products_control/models/user.dart';
import 'package:products_control/services/database.dart';
import 'package:provider/provider.dart';

class CreateBoxItemForm extends StatefulWidget {
  final BoxItem boxItem;

  CreateBoxItemForm({Key key, this.boxItem}) : super(key: key);

  @override
  _CreateBoxItemFormState createState() => _CreateBoxItemFormState();
}

class _CreateBoxItemFormState extends State<CreateBoxItemForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  User user;
  BoxItem boxItem = BoxItem();
  bool isNew = true;

  @override
  void initState() {
    // if (widget.boxItem != null) {
    //   isNew = false;
    //   boxItem = widget.boxItem.copy();
    // }

    super.initState();
  }

  void _saveWorkout() async {
    if (_formKey.currentState.saveAndValidate()) {
      //print(workout.toMap());
      if (boxItem.uid == null) {
        boxItem.author = user.id;
      }

      await DatabaseService().addOrUpdateBoxItem(boxItem);
      Navigator.of(context).pop(boxItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    return FormBuilder(
      key: _formKey,
      autovalidate: false,
      initialValue: {},
      readOnly: false,
      child: Container(
        padding: EdgeInsets.all(
          20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Добавляем новый продукт',
              style: TextStyle(
                color: Colors.black,
                fontSize: 45.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 30.0,
              ),
              child: TextFormField(
                initialValue: boxItem.title,
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  labelText: 'Продукт',
                  hintText: 'Молоко',
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
                onChanged: (dynamic val) {
                  setState(() {
                    boxItem.title = val;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Пожалуйста введите продукт';
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
                initialValue: boxItem.description,
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  labelText: 'Категория',
                  hintText: 'Еда',
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
                onChanged: (dynamic val) {
                  setState(() {
                    boxItem.description = val;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Пожалуйства введите категорию';
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
                initialValue: boxItem.amount,
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  labelText: 'Количество',
                  hintText: '0',
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
                onChanged: (dynamic val) {
                  setState(() {
                    boxItem.amount = val;
                  });
                },
                validator: (value) {
                  if (value.isEmpty || int.tryParse(value) == null) {
                    return 'Пожалуйста введите число';
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
                initialValue: boxItem.expirationDate,
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  labelText: 'Срок годности',
                  hintText: '20/11/2020',
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
                onChanged: (dynamic val) {
                  setState(() {
                    boxItem.expirationDate = val;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Пожалуйства введите срок годности';
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
                      //СЮДА!!!!!!!!!!!!!!!!
                      _saveWorkout();
                      print(boxItem);
                    },
                    child: Text(
                      'Добавить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                      ),
                    ),
                    color: Colors.deepPurple,
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
