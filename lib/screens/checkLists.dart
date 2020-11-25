import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_control/models/checkListData.dart';
import 'package:products_control/widgets/checkListsList.dart';
import 'addCheckList.dart';

class CheckListsScreen extends StatelessWidget {
  // Each screen that has a floating action button will have this method
  // TODO: see if creating a wrapper component for the FAB is necessary
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
            Navigator.push<CheckList>(
                context, MaterialPageRoute(builder: (ctx) => AddCheckList()));
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
