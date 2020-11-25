import 'package:flutter/material.dart';
import 'package:products_control/models/checkListData.dart';
import 'package:products_control/screens/addCheckList.dart';
import 'package:provider/provider.dart';
import 'package:products_control/models/user.dart';
import 'package:products_control/services/database.dart';
import 'dart:async';

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

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    if (start) {
      loadData();
      start = false;
    }
    //ЭТО НАДО РЕШИТЬ!!!!!!!!!!!!!!!!!!!
    // loadData();
    //ЭТО НАДО РЕШИТЬ!!!!!!!!!!!!!!!!!!!

    var checkListsList = Expanded(
      child: ListView.builder(
          itemCount: checkLists.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddCheckList(checkList: checkLists[i])));
              },
              child: Card(
                key: Key(checkLists[i].id),
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  child: ListTile(
                    leading: Icon(Icons.kitchen),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    title: Text(checkLists[i].title),
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
      checkListsList,
    ]);
  }
}
