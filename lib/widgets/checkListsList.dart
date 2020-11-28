import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:products_control/models/checkListData.dart';
import 'package:products_control/screens/addCheckList.dart';
import 'package:products_control/widgets/pageTitle.dart';
import 'package:products_control/widgets/shareIcon.dart';
import 'package:products_control/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:products_control/models/user.dart';
import 'package:products_control/services/database.dart';
import 'dart:async';

import 'package:share/share.dart';

class CheckListsList extends StatefulWidget {
  @override
  _CheckListsListState createState() => _CheckListsListState();
}

class _CheckListsListState extends State<CheckListsList> {
  User user;
  bool start = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (checkListsStreamSubscription != null) {
      print('unsubscribing');
      checkListsStreamSubscription.cancel();
    }
    super.dispose();
  }

  StreamSubscription<List<CheckList>> checkListsStreamSubscription;
  var db = DatabaseService();
  var checkLists = List<CheckList>();

  void loadData() {
    print("LOAD DATA");
    var stream = db.getCheckLists(author: user.id);
    checkListsStreamSubscription = stream.listen((List<CheckList> data) {
      setState(() {
        checkLists = data;
      });
    });
  }

  Future<bool> _deleteCheckList(checkList) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text(
                  "Точно удаляем список?",
                  style: TextStyle(color: Colors.deepPurple),
                ),
                actions: <Widget>[
                  FlatButton(
                      child: Text("Да"),
                      color: Colors.deepPurple,
                      onPressed: () {
                        print("da");
                        DatabaseService().deleteCheckList(checkList);
                        Navigator.pop(context, true);
                        buildToast('Список был удален');
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

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    if (start) {
      loadData();
      start = false;
    }

    var checkListsList = Expanded(
      child: ListView.builder(
          itemCount: checkLists.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddCheckList(checkList: checkLists[i])));
              },
              onLongPress: () {
                _deleteCheckList(checkLists[i]);
              },
              child: Card(
                key: Key(checkLists[i].id),
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  child: ListTile(
                      leading: Icon(Icons.list),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      title: Text(checkLists[i].title),
                      trailing: ShareIcon(
                        checkList: checkLists[i],
                      )
                      // InkWell(
                      //   child: Icon(
                      //     Icons.share,
                      //     color: Colors.deepPurple,
                      //   ),
                      //   onTap: () {
                      //     print("tap");
                      //     share(context, checkLists[i]);
                      //   },
                      // ),
                      ),

                  // onTap: () {
                  //   print('Tapped');
                  // },
                ),
              ),
            );
          }),
    );

    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: PageTitle(
          text: 'Мои списки покупок',
        ),
      ),
      checkListsList,
    ]);
  }
}
