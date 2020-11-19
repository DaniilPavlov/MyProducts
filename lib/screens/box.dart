import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_control/widgets/tappableCard.dart';
import '../widgets/pageTitle.dart';
import '../widgets/pageSubtitle.dart';
import '../widgets/fullScreenOverlay.dart';
import '../widgets/createBoxItemForm.dart';

class BoxScreen extends StatelessWidget {
// Each screen that has a floating action button will have this method
  // TODO: see if creating a wrapper component for the FAB is necessary
  Widget renderFloatingActionButton(BuildContext context) {
    return Container(
      height: 80.0,
      width: 80.0,
      child: FittedBox(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
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
            CreateBoxItemForm(),
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
                text: 'Моя коробка',
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PageSubtitle(
                  text: 'Товары',
                  topPadding: 0.0,
                ),
                TappableCard(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.kitchen),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      title: Text("Яйца"),
                      subtitle: Text("10 штук"),
                      trailing: Text(
                        '1',
                        style: TextStyle(
                          fontSize: 26.0,
                        ),
                      ),
                    ),
                  ],
                  onTap: () {
                    print('Tapped');
                  },
                ),
                TappableCard(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.kitchen),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      title: Text("Молоко"),
                      subtitle: Text("Простоквашино 1л"),
                      trailing: Text(
                        '2',
                        style: TextStyle(
                          fontSize: 26.0,
                        ),
                      ),
                    ),
                  ],
                  onTap: () {
                    print('Tapped');
                  },
                ),
                TappableCard(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.kitchen),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      title: Text("Хлеб"),
                      subtitle: Text("Батон нарезной"),
                      trailing: Text(
                        '1',
                        style: TextStyle(
                          fontSize: 26.0,
                        ),
                      ),
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
