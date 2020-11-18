import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/pageTitle.dart';
import '../widgets/pageSubtitle.dart';
import '../widgets/tappableCard.dart';

class CheckListsScreen extends StatelessWidget {
  // Each screen that has a floating action button will have this method
  // TODO: see if creating a wrapper component for the FAB is necessary
  Widget renderFloatingActionButton() {
    return Container(
      height: 90.0,
      width: 90.0,
      child: FittedBox(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            print('Tapped');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 40.0,
              ),
              child: PageTitle(
                text: 'Мои списки покупок',
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PageSubtitle(
                  text: 'Списки',
                  topPadding: 0.0,
                ),
                TappableCard(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.list),
                      title: Text('Еженедельные продукты'),
                      subtitle: Text('Мясо, чеснок, макароны, яйца'),
                    ),
                  ],
                  onTap: () {
                    print('Tapped');
                  },
                ),
                TappableCard(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.list),
                      title: Text('Футбол'),
                      subtitle: Text('Чипсы, сухарики, газировка'),
                    ),
                  ],
                  onTap: () {
                    print('Tapped');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}