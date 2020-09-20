import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/appbar.dart';
import 'package:flutter_front/common/widgets/recipe_card.dart';
import 'package:flutter_tts_improved/flutter_tts_improved.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'common/asset_path.dart';
import 'common/color.dart';
import 'common/data_class.dart';
import 'dart:core';

import 'common/font.dart';
import 'common/ip.dart';
import 'fold_page.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class FoldCompletePage extends StatefulWidget {
  final RecipeCard recipeCard;

  FoldCompletePage(this.recipeCard);

  @override
  _FoldCompletePageState createState() => _FoldCompletePageState(recipeCard);
}

class _FoldCompletePageState extends State<FoldCompletePage> {

  RecipeCard recipeCard;

  _FoldCompletePageState(RecipeCard _recipeCard) {
    recipeCard = _recipeCard;
  }

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
        appBar: DefaultAppBar(
          title : "완성!"
        ),
        // 2-1. 상세 화면 (전체 화면 세팅1)
        body: ModalProgressHUD(
          inAsyncCall: _inAsyncCall,
          progressIndicator: CircularProgressIndicator(),
          opacity: 0.1,
          child: Container()
        )

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
        FoldProcess(imgPath: "images/golden_frog_icon.png", subtitleExplainText: "동해물과 백두산이", ttsExplainText: "상처를 치료해줄 사람 어디 없나"),
        FoldProcess(imgPath: "images/fold_icon.png", subtitleExplainText: "마르고 닳도록", ttsExplainText: "가만히 놔두다간 끊임없이 덧나"),
        FoldProcess(imgPath: "images/fold_icon.png", subtitleExplainText: "하느님이 보우하사", ttsExplainText: "사랑도 사람도 너무나도 겁나"),
        FoldProcess(imgPath: "images/fold_icon.png", subtitleExplainText: "우리나라 만세", ttsExplainText: "혼자인게 무서워 난 잊혀질까 두려워"),
        FoldProcess(imgPath: "images/fold_icon.png", subtitleExplainText: "무궁화 삼천리", ttsExplainText: "언제나 외톨이 맘의 문을 닫고"),
        FoldProcess(imgPath: "images/fold_icon.png", subtitleExplainText: "화려강산", ttsExplainText: "슬픔을 등에 지고 살아가는 바보"),
        FoldProcess(imgPath: "images/fold_icon.png", subtitleExplainText: "대한사람 대한으로", ttsExplainText: "두 눈을 감고 두 귀를 막고"),
        FoldProcess(imgPath: "images/fold_icon.png", subtitleExplainText: "길이 보전하세", ttsExplainText: "캄캄한 어둠속에 내 자신을 가둬"),

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
