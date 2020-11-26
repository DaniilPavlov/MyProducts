import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:products_control/screens/authStatus.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'models/user.dart';

void main() {
  runApp(MyProductsApp());
}

class MyProductsApp extends StatefulWidget {
  @override
  _MyProductsAppState createState() => _MyProductsAppState();
}

class _MyProductsAppState extends State<MyProductsApp> {
  //подписка на стрим, который возвращает пользователя
  final db = Firestore.instance;
  StreamSubscription<User> userStreamSubscription;

  //стрим юзера вместе с данными
  Stream<User> userDataStream;

  //будем ждать нашего текущего пользователя, но не входим
  //когда будет стрим юзера с юзер дейта внутри, тогда мы будем его загружать
  StreamSubscription<User> setUserDataStream() {
    final auth = AuthService();
    return auth.currentUser.listen((user) {
      userDataStream = auth.getCurrentUserWithData(user);
      setState(() {});
    });
  }

  //первый раз, когда виджет создается, вызываем метод setUserDataStream()
  @override
  void initState() {
    super.initState();
    userStreamSubscription = setUserDataStream();
  }

  //каждый раз когда мы создаем новый StreamSubscription, нам нужно от него отписаться в dispose методе
  @override
  void dispose() {
    super.dispose();
    userStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // С помощью StreamProvider<User> мы всегда знаем текущего нашего пользователя
    return StreamProvider<User>.value(
        value: userDataStream,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "MyProducts",
          theme: ThemeData(
              textSelectionHandleColor: Colors.deepPurple,
              textSelectionColor: Colors.deepPurple,
              cursorColor: Colors.deepPurple,
              primaryColor: Colors.deepPurple,
              textTheme: TextTheme(title: TextStyle(color: Colors.white))),
          home: AuthStatusScreen(),
        ));
  }
}
