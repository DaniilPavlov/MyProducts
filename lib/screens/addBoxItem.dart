import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:products_control/models/boxData.dart';
import 'package:products_control/models/user.dart';
import 'package:products_control/services/database.dart';
import 'package:provider/provider.dart';

class AddBoxItem extends StatefulWidget {
  final BoxItem boxItem;

  AddBoxItem({Key key, this.boxItem}) : super(key: key);

  @override
  _AddBoxItemState createState() => _AddBoxItemState();
}

class _AddBoxItemState extends State<AddBoxItem> {
  final _formKey = GlobalKey<FormBuilderState>();
  String dropdownValue = 'Еда';
  User user;
  BoxItem boxItem = BoxItem();
  bool isOld = false;

  @override
  void initState() {
    if (widget.boxItem != null) {
      isOld = true;
      boxItem = widget.boxItem.copy();
    }
    super.initState();
  }

  void _saveProduct() async {
    if (_formKey.currentState.saveAndValidate()) {
      if (boxItem.id == null) {
        boxItem.author = user.id;
      }

      await DatabaseService().addOrUpdateBoxItem(boxItem);
      Navigator.of(context).pop(boxItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    return isOld
        ? Scaffold(
            body: FormBuilder(
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
                        hintText: 'Продукт',
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
                    child: DropdownButtonFormField<String>(
                      value: boxItem.category,
                      isExpanded: true,
                      icon: Icon(Icons.list),
                      iconSize: 40.0,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Категория',
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
                      items: <String>[
                        'Еда',
                        'Напитки',
                        'Аптечка',
                        'Для тела',
                        'Для дома',
                        'Другое'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        setState(() {
                          boxItem.category = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Пожалуйста выберите категорию';
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
                            _saveProduct();
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
          ))




        : FormBuilder(
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
                        hintText: 'Продукт',
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
                    child: DropdownButtonFormField<String>(
                      value: boxItem.category,
                      isExpanded: true,
                      icon: Icon(Icons.list),
                      iconSize: 40.0,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Категория',
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
                      items: <String>[
                        'Еда',
                        'Напитки',
                        'Аптечка',
                        'Для тела',
                        'Для дома',
                        'Другое'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        setState(() {
                          boxItem.category = val;
                        });
                      },
                      validator: (val) {
                        if (val == null) {
                          return 'Пожалуйста выберите категорию';
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
                            _saveProduct();
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
