import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:products_control/screens/addCheckListItem.dart';
import 'package:products_control/models/checkListData.dart';
import 'package:products_control/models/user.dart';
import 'package:products_control/services/database.dart';
import 'package:products_control/widgets/saveButton.dart';
import 'package:products_control/widgets/toast.dart';
import 'package:provider/provider.dart';

class AddCheckList extends StatefulWidget {
  final CheckList checkList;

  AddCheckList({Key key, this.checkList}) : super(key: key);

  @override
  _AddCheckListState createState() => _AddCheckListState();
}

class _AddCheckListState extends State<AddCheckList> {
  final _fbKey = GlobalKey<FormBuilderState>();
  User user;
  CheckList checkList = CheckList(items: []);
  bool isOld = false;

  @override
  void initState() {
    if (widget.checkList != null) {
      print("auf");
      isOld = true;
      checkList = widget.checkList.copy();
    }
    super.initState();
  }

  void _saveCheckList() async {
    if (_fbKey.currentState.saveAndValidate()) {
      if (checkList.items == null || checkList.items.length == 0) {
        buildToast('Пожалуйста добавьте как минимум 1 товар');
        return;
      }

      //print(workout.toMap());
      if (checkList.id == null) {
        checkList.author = user.id;
      }

      await DatabaseService().addOrUpdateCheckList(checkList);
      Navigator.of(context).pop(checkList);
    } else {
      buildToast('Ой! Что-то пошло не так.');
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('${isOld ? 'Добавляем ' : 'Изменяем '} список'),
          actions: <Widget>[SaveButton(onPressed: _saveCheckList)],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          onPressed: () async {
            var item = await Navigator.push<CheckListItem>(context,
                MaterialPageRoute(builder: (ctx) => AddCheckListItem()));
            if (item != null)
              setState(() {
                checkList.items.add(item);
              });
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: FormBuilder(
              // context,
              key: _fbKey,
              autovalidate: false,
              initialValue: {},
              readOnly: false,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    initialValue: checkList.title,
                    attribute: "title",
                    decoration: InputDecoration(
                      labelText: "Название",
                    ),
                    onChanged: (dynamic val) {
                      setState(() {
                        checkList.title = val;
                      });
                    },
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(100),
                    ],
                  ),
                  FormBuilderTextField(
                    initialValue: checkList.description,
                    attribute: "description",
                    decoration: InputDecoration(
                      labelText: "Описание",
                    ),
                    onChanged: (dynamic val) {
                      setState(() {
                        checkList.description = val;
                      });
                    },
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(500),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Товары',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  checkList.items.length <= 0
                      ? Text(
                          'Пожалуйста добавьте хотя бы 1 товар',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      : _buildItems()
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildItems() {
    return Container(
        child: Column(
            children: checkList.items
                .map((item) => Card(
                      elevation: 2.0,
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: InkWell(
                        onTap: () async {
                          var ind = checkList.items.indexOf(item);
                          var modifiedItem =
                              await Navigator.push<CheckListItem>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => AddCheckListItem(
                                          checkListItem: item)));
                          if (modifiedItem != null) {
                            setState(() {
                              checkList.items[ind] = modifiedItem;
                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.deepPurple,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Colors.white24))),
                                ),
                                Text('${item.title}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                Text('Количество: ${item.amount}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.keyboard_arrow_right,
                                    color: Colors.black),
                              ]),
                        ),
                      ),
                    ))
                .toList()));
  }
}
