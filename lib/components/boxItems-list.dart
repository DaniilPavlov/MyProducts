import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:products_control/services/auth.dart';
import 'package:products_control/widgets/tappableCard.dart';
import 'package:provider/provider.dart';
import 'package:products_control/models/user.dart';
import 'package:products_control/models/data.dart';
import 'package:products_control/services/database.dart';
import 'dart:async';
// import 'package:workouts/pages/workout-details.dart';

class BoxItemsList extends StatefulWidget {
  @override
  _BoxItemsListState createState() => _BoxItemsListState();
}

class _BoxItemsListState extends State<BoxItemsList> {
  User user;

  DatabaseService db = DatabaseService();
  var boxItems = List<BoxItem>();

  @override
  void initState() {
    // print(user.id);
    loadData();
    super.initState();
  }

  var filterHeight = 0.0;
  var filterText = '';

  // @override
  // void dispose() {
  //   if (boxItemsStreamSubscription != null) {
  //     print('unsubscribing');
  //     boxItemsStreamSubscription.cancel();
  //   }
  //   super.dispose();
  // }

  // StreamSubscription<List<BoxItem>> boxItemsStreamSubscription;

  loadData() async {
    print("ASFSAFSAFASFSA");

    var stream = db.getBoxItems(author: user.id);
    stream.listen((List<BoxItem> data) {
      setState(() {
        boxItems = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    //ЭТО НАДО РЕШИТЬ!!!!!!!!!!!!!!!!!!!
    // loadData();
    //ЭТО НАДО РЕШИТЬ!!!!!!!!!!!!!!!!!!!
    var filterInfo = Container(
      margin: EdgeInsets.only(top: 30, left: 7, right: 7, bottom: 5),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
      height: 40,
      child: RaisedButton(
        child: Row(
          children: <Widget>[
            Icon(Icons.filter_list),
            Text(
              filterText,
              style: TextStyle(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            loadData();
            filterHeight = (filterHeight == 0.0 ? 220.0 : 0.0);
          });
        },
      ),
    );

    var widgetsList = Expanded(
      child: ListView.builder(
          itemCount: boxItems.length,
          itemBuilder: (context, i) {
            return InkWell(
              child: Card(
                key: Key(boxItems[i].uid),
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  child: ListTile(
                    leading: Icon(Icons.kitchen),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    title: Text(boxItems[i].title),
                    subtitle: Text(boxItems[i].expirationDate),
                    trailing: Text(
                      boxItems[i].amount,
                      style: TextStyle(
                        fontSize: 26.0,
                      ),
                    ),
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
      filterInfo,
      // filterForm,
      widgetsList,
    ]);
  }
}
