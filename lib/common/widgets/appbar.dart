import 'package:flutter/material.dart';
import '../color.dart';
import '../font.dart';
import '../asset_path.dart';

Widget buildDefaultAppbar(){
  return AppBar(
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    centerTitle: true,
    title: Container(
        width: 135,
        child: Image.asset("images/nav_logo.png")),

    elevation: 0.0,
    flexibleSpace: Container(
      decoration: BoxDecoration(),
    ),
    actions: <Widget>[
      IconButton(
        icon: new Icon(Icons.person_outline),
        tooltip: 'Wow',
        onPressed: () => {},
      ),
      SizedBox(
        width: 30,
      )
    ],
  );
}