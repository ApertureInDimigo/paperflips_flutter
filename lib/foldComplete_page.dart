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
import 'package:glitters/glitters.dart';

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
          child: _buildCompletePage(),
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
        FoldProcess(imgPath: IconPath.golden_frog, subtitleExplainText: "동해물과 백두산이", ttsExplainText: "상처를 치료해줄 사람 어디 없나"),
        FoldProcess(imgPath: IconPath.fold, subtitleExplainText: "마르고 닳도록", ttsExplainText: "가만히 놔두다간 끊임없이 덧나"),
        FoldProcess(imgPath: IconPath.fold, subtitleExplainText: "하느님이 보우하사", ttsExplainText: "사랑도 사람도 너무나도 겁나"),
        FoldProcess(imgPath: IconPath.fold, subtitleExplainText: "우리나라 만세", ttsExplainText: "혼자인게 무서워 난 잊혀질까 두려워"),
        FoldProcess(imgPath: IconPath.fold, subtitleExplainText: "무궁화 삼천리", ttsExplainText: "언제나 외톨이 맘의 문을 닫고"),
        FoldProcess(imgPath: IconPath.fold, subtitleExplainText: "화려강산", ttsExplainText: "슬픔을 등에 지고 살아가는 바보"),
        FoldProcess(imgPath: IconPath.fold, subtitleExplainText: "대한사람 대한으로", ttsExplainText: "두 눈을 감고 두 귀를 막고"),
        FoldProcess(imgPath: IconPath.fold, subtitleExplainText: "길이 보전하세", ttsExplainText: "캄캄한 어둠속에 내 자신을 가둬"),

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

Widget _columnStar() {
  return Column(
    children: [
      Icon(Icons.star, color: Colors.yellow, size: 40,),
      Icon(Icons.star, color: Colors.yellow, size: 40,),
      Icon(Icons.star, color: Colors.yellow, size: 40,),
      Icon(Icons.star, color: Colors.yellow, size: 40,),
    ],
  );
}

Widget _rowStar() {
  return Row(
    children: [
      Icon(Icons.star, color: Colors.yellow, size: 40,),
      Icon(Icons.star, color: Colors.yellow, size: 40,),
      Icon(Icons.star, color: Colors.yellow, size: 40,),
      Icon(Icons.star, color: Colors.yellow, size: 40,),
    ],
  );
}

Widget _buildCompletePage() {
  return Container(
    color: Colors.grey,
    child: Center(
        child:
        Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: ColoredBox(color: Colors.grey),
                  ),
                  Center(child: Image.asset(IconPath.golden_frog)),
                  Glitters(
                    minSize: 25,
                    maxSize: 40,
                    interval: Duration(milliseconds: 100),
                    maxOpacity: 0.9,
                    color: Colors.orange,
                  ),
                  Glitters(
                    minSize: 25,
                    maxSize: 40,
                    duration: Duration(milliseconds: 200),
                    outDuration: Duration(milliseconds: 500),
                    interval: Duration.zero,
                    color: Colors.green,
                    maxOpacity: 0.7,
                  ),
                  Glitters(
                    minSize: 25,
                    maxSize: 40,
                    interval: Duration(milliseconds: 100),
                    maxOpacity: 0.9,
                    color: Colors.yellowAccent,
                  ),
                  Glitters(
                    minSize: 25,
                    maxSize: 40,
                    duration: Duration(milliseconds: 200),
                    outDuration: Duration(milliseconds: 500),
                    interval: Duration.zero,
                    color: Colors.white,
                    maxOpacity: 0.7,
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 80),
                child: Text('테스트', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),)
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100)),
                ),
                width: 250,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Center(child: Text('완성', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
    ),
  );
}