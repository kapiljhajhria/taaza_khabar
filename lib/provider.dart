import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  Provider({Key key,Widget child, this.isDarkModeOn}) : super(key: key, child: child);

  final bool isDarkModeOn;

  static bool of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider)as Provider).isDarkModeOn;
  }

  @override
  bool updateShouldNotify( Provider oldWidget) {
    return true;
  }
}