import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/pageTitle.dart';
import '../widgets/pageSubtitle.dart';
import '../widgets/tappableCard.dart';
import '../widgets/fullScreenOverlay.dart';
import '../widgets/createCheckListForm.dart';

class CheckListsScreen extends StatelessWidget {
  // Each screen that has a floating action button will have this method
  // TODO: see if creating a wrapper component for the FAB is necessary
  Widget renderFloatingActionButton(BuildContext context) {
    return Container(
      height: 80.0,
      width: 80.0,
      child: FittedBox(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          onPressed: () {
            _showOverlay(context);
          },
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(
      FullScreenOverlay(
        RouteSettings(
          arguments: FullScreenOverlayRouteArguments(
            CreateCheckListForm(),
          ),
        ),
        ImageFilter.blur(),
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
