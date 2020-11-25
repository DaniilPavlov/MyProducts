import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:products_control/models/checkListData.dart';

class AddCheckListItem extends StatefulWidget {
  final CheckListItem checkListItem;

  AddCheckListItem({Key key, this.checkListItem}) : super(key: key);

  @override
  _AddCheckListItemState createState() => _AddCheckListItemState();
}

class _AddCheckListItemState extends State<AddCheckListItem> {
  final _formKey = GlobalKey<FormBuilderState>();
  CheckListItem checkListItem = CheckListItem();

  @override
  void initState() {
    if (widget.checkListItem != null)
      checkListItem = widget.checkListItem.copy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Text(
            //   'Добавляем новый продукт',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 45.0,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 30.0,
              ),
              child: TextFormField(
                initialValue: checkListItem.title,
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
                    checkListItem.title = val;
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
                initialValue: checkListItem.amount,
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
                    checkListItem.amount = val;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 120.0,
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop(checkListItem);
                    },
                    child: Text(
                      'Сохранить',
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
    ));
  }
}
