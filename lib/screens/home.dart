import 'package:flutter/material.dart';
import 'package:products_control/services/auth.dart';
import '../widgets/pageTitle.dart';
import '../widgets/pageSubtitle.dart';
import '../widgets/tappableCard.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

// TODO: Map cards over dummy data
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("MyProducts",style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  AuthService().logOut();
                },
                icon: Icon(Icons.exit_to_app, color: Colors.black38),
                label: SizedBox.shrink())
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: PageTitle(
                  text: 'Главная',
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PageSubtitle(
                    text: 'Недавние списки покупок',
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
                  PageSubtitle(
                    text: 'Мои товары',
                    topPadding: 20.0,
                  ),
                  TappableCard(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.inbox),
                        title: Text('Продукты'),
                        subtitle: Text('10 яиц, сыр, 1л молока'),
                      ),
                    ],
                    onTap: () {
                      print('Tapped');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
