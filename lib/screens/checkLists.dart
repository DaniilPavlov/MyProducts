import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_control/models/checkListData.dart';
import 'package:products_control/services/database.dart';
import 'package:products_control/widgets/checkListsList.dart';
import 'addCheckList.dart';

class CheckListsScreen extends StatelessWidget {
  Widget renderFloatingActionButton(BuildContext context) {
    return Container(
      height: 70.0,
      width: 70.0,
      child: FittedBox(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push<CheckList>(context,
                MaterialPageRoute(builder: (ctx) {
              CheckList checkList = CheckList();
              DatabaseService().addOrUpdateCheckList(checkList);
              return AddCheckList(checkList: checkList);
            }));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CheckListsList());
  }
}
