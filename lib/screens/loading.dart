import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          color: Colors.white,
          child: SpinKitRing(
            color: Colors.black,
            size: 50.0,
          ),
        )
    );
  }
}
