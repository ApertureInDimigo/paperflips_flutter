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
          centerTitle: true,
          title: FractionallySizedBox(
              child: Text("\"학\" 소개",
                style: TextStyle(fontSize: 18, fontFamily: Font.bold))
          ),
          actions: <Widget>[

          ],
        ),
     );
  }

  }
