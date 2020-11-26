import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:products_control/screens/addCheckListItem.dart';
import 'package:products_control/models/checkListData.dart';
import 'package:products_control/models/user.dart';
import 'package:products_control/services/database.dart';
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
  CheckList checkList = CheckList();
  bool isOld = false;
  bool start = true;

  @override
  void initState() {
    if (widget.checkList != null) {
      isOld = true;
      checkList = widget.checkList.copy();
    }
    super.initState();
  }

  // void _saveCheckList() async {
  //   if (_fbKey.currentState.saveAndValidate()) {
  //
  //     if (checkList.id == null) {
  //       checkList.author = user.id;
  //     }
  //
  //     await DatabaseService().addOrUpdateCheckList(checkList);
  //     Navigator.of(context).pop(checkList);
  //   } else {
  //     buildToast('Ой! Что-то пошло не так.');
  //   }
  // }

  @override
  void dispose() {
    if (checkListItemsStreamSubscription != null) {
      print('unsubscribing');
      checkListItemsStreamSubscription.cancel();
    }
    super.dispose();
  }

  StreamSubscription<List<CheckListItem>> checkListItemsStreamSubscription;
  var db = DatabaseService();
  var checkListItems = List<CheckListItem>();

  void loadData() {
    print("LOAD CHECK LIST ITEMS");
    var stream = db.getCheckListItems(listId: checkList.id);
    checkListItemsStreamSubscription =
        stream.listen((List<CheckListItem> data) {
      setState(() {
        print("load");
        checkListItems = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    if (start && isOld) {
      loadData();
      start = false;
    }

    return WillPopScope(
        onWillPop: () async {
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          if (_fbKey.currentState.saveAndValidate()) {
            if (checkList.id == null) {
              checkList.author = user.id;
            }

            await DatabaseService().addOrUpdateCheckList(checkList);
            Navigator.of(context).pop(checkList);
          } else {
            buildToast('Пустой список не был создан');
          }
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text('${isOld ? 'Добавляем ' : 'Изменяем '} список'),
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
                    item.listId = checkList.id;
                    DatabaseService().addOrUpdateCheckListItem(item);
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      checkListItems.length <= 0
                          ? Text(
                              'Пожалуйста добавьте хотя бы 1 товар',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          : _buildItems()
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _buildItems() {
    return Container(
        child: Column(
            children: checkListItems
                .map((item) => Card(
                      elevation: 2.0,
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: InkWell(
                        onTap: () async {
                          var modifiedItem = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      AddCheckListItem(checkListItem: item)));
                          await DatabaseService()
                              .addOrUpdateCheckListItem(modifiedItem);
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
                                InkWell(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                  onTap: () {
                                    var ind = checkListItems.indexOf(item);
                                    print(ind);
                                    _deleteCheckListItem(checkListItems[ind]);
                                  },
                                ),
                              ]),
                        ),
                      ),
                    ))
                .toList()));
  }

  Future<bool> _deleteCheckListItem(CheckListItem checkListItem) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text(
                  "Точно удаляем продукт?",
                  style: TextStyle(color: Colors.deepPurple),
                ),
                actions: <Widget>[
                  FlatButton(
                      child: Text("Да"),
                      color: Colors.deepPurple,
                      onPressed: () {
                        print("da");
                        DatabaseService().deleteCheckListItem(checkListItem);
                        Navigator.pop(context, true);
                        loadData();
                      }),
                  SizedBox(
                    width: 100,
                  ),
                  FlatButton(
                    child: Text("Нет"),
                    color: Colors.deepPurple,
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ]));
  }
}
