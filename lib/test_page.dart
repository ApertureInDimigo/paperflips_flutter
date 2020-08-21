import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/appbar.dart';
import 'package:flutter_front/common/widgets/recipe_card.dart';

import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';
import 'common/color.dart';
import 'common/data_class.dart';
import 'dart:core';

import 'common/font.dart';
import 'common/ip.dart';
import 'fold_page.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class TestPage extends StatefulWidget {
//  final RecipeCard recipeCard;

//  TestPage(this.recipeCard);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  RecipeCard recipeCard;


  bool _inAsyncCall = false;

  @override
  void initState() {
    super.initState();
    _inAsyncCall = false;
//    _getMySongList();
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: Text("SlidingUpPanelExample"),
        ),
        body: Stack(
          children: <Widget>[
            Center(child: Text("This is the Widget behind the sliding panel"),),

            SlidingUpPanel(
              panel: Center(child: Text("This is the sliding Widget"),),
            )
          ],
        )
    );

    return Material(
      child: SlidingUpPanel(
        backdropEnabled: true,
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
        body: Scaffold(
          appBar: AppBar(
            title: Text("SlidingUpPanelExample"),
          ),
          body:  Center(
            child: Text("This is the Widget behind the sliding panel"),
          ),
        ),
      ),
    );
  }


  void goFoldPage(recipeCard) async{
    setState(() {
      _inAsyncCall = true;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _inAsyncCall = false;
    });
    Navigator.push(
      context,
      FadeRoute(page: FoldPage(recipeCard, [
        FoldProcess(subtitleExplainText: "동해물과 백두산이", ttsExplainText: "상처를 치료해줄 사람 어디 없나"),
        FoldProcess(subtitleExplainText: "마르고 닳도록", ttsExplainText: "가만히 놔두다간 끊임없이 덧나"),
        FoldProcess(subtitleExplainText: "하느님이 보우하사", ttsExplainText: "사랑도 사람도 너무나도 겁나"),
        FoldProcess(subtitleExplainText: "우리나라 만세", ttsExplainText: "혼자인게 무서워 난 잊혀질까 두려워"),
        FoldProcess(subtitleExplainText: "무궁화 삼천리", ttsExplainText: "언제나 외톨이 맘의 문을 닫고"),
        FoldProcess(subtitleExplainText: "화려강산", ttsExplainText: "슬픔을 등에 지고 살아가는 바보"),
        FoldProcess(subtitleExplainText: "대한사람 대한으로", ttsExplainText: "두 눈을 감고 두 귀를 막고"),
        FoldProcess(subtitleExplainText: "길이 보전하세", ttsExplainText: "캄캄한 어둠속에 내 자신을 가둬"),
        FoldProcess(subtitleExplainText: "", ttsExplainText: "hello"),
        FoldProcess(subtitleExplainText: "안녕하세요", ttsExplainText: "안녕하세요")
      ])),
    );

  }

}



class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}
