import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:products_control/models/user.dart';
import 'package:products_control/models/data.dart';
import 'package:products_control/services/database.dart';
import 'dart:async';

class BoxItemsList extends StatefulWidget {
  @override
  _BoxItemsListState createState() => _BoxItemsListState();
}

class _BoxItemsListState extends State<BoxItemsList> {
  User user;
  bool start = true;

  @override
  void initState() {
    filter(true);
    super.initState();
  }

  @override
  void dispose() {
    if (boxItemsStreamSubscription != null) {
      print('unsubscribing');
      boxItemsStreamSubscription.cancel();
    }
    super.dispose();
  }

  StreamSubscription<List<BoxItem>> boxItemsStreamSubscription;
  var db = DatabaseService();
  var boxItems = List<BoxItem>();

  var filterHeight = 0.0;
  var filterText = '';
  var filterCategory = 'Все продукты';

  void filter(bool clear) {
    print("Filter");
    if (clear) {
      filterCategory = 'Все продукты';
    }

    setState(() {
      filterText = filterCategory;
      filterHeight = 0;
    });
  }

  void loadData() {
    print("LOAD DATA");
    bool isFiltered = true;
    var stream = db.getBoxItems(
        author: user.id,
        category: filterCategory != "Все продукты" ? filterCategory : null);
    boxItemsStreamSubscription = stream.listen((List<BoxItem> data) {
      setState(() {
        if (isFiltered) {
          print("YES");
          boxItems = data;
          isFiltered = false;
        } else {
          boxItemsStreamSubscription.cancel();
          print("NO");
          loadData();
        }
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
    var filterInfo = Container(
      margin: EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 10),
      decoration: BoxDecoration(color: Colors.deepPurple),
      height: 50,
      child: RaisedButton(
        child: Row(
          children: <Widget>[
            Icon(Icons.filter_list),
            SizedBox(
              width: 30,
            ),
            Text(
              filterText,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            filterHeight = (filterHeight == 0.0 ? 160.0 : 0.0);
          });
        },
      ),
    );

    var categoryMenuItems = <String>[
      'Все продукты',
      'Еда',
      'Напитки',
      'Аптечка',
      'Для тела',
      'Для дома',
      'Другое'
    ].map((String value) {
      return new DropdownMenuItem<String>(
        value: value,
        child: new Text(value),
      );
    }).toList();

    var filterForm = AnimatedContainer(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Категория'),
                items: categoryMenuItems,
                value: filterCategory,
                onChanged: (String val) => setState(() => filterCategory = val),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        filter(false);
                        loadData();
                      },
                      child: Text("Применить",
                          style: TextStyle(color: Colors.white)),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        filter(true);
                        loadData();
                      },
                      child: Text("Очистить",
                          style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: filterHeight,
    );

    var widgetsList = Expanded(
      child: ListView.builder(
          itemCount: boxItems.length,
          itemBuilder: (context, i) {
            return InkWell(
              // onTap: () {
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (ctx) => WorkoutDetails(id: workouts[i].id)));
              // },
              child: Card(
                key: Key(boxItems[i].id),
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
      filterForm,
      widgetsList,
    ]);
  }
}
