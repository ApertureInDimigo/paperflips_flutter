import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './common/color.dart';
import './common/font.dart';
import './common/asset_path.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String dirname;

  _MainPageState() {
    dirname = "172.31.99.194";   //CMD창에 ipconfig 쳐보고 자기 Ipv4 주소 적어서 해보세요..
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          centerTitle: true,
          title: FractionallySizedBox(
              widthFactor: 2 / 5, child: Image.asset("images/nav_logo.png")),
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
        ),
     );
  }

  }
