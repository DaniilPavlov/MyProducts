import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_control/widgets/boxItemsList.dart';
import '../widgets/fullScreenOverlay.dart';
import 'addBoxItem.dart';

class BoxScreen extends StatelessWidget {
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
            AddBoxItem(),
          ),
        ),
        ImageFilter.blur(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BoxItemsList());
  }
}
