import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/appbar.dart';
import 'package:flutter_front/common/widgets/recipe_card.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'common/color.dart';
import 'common/data_class.dart';
import 'dart:core';

import 'common/font.dart';
import 'common/ip.dart';
import 'fold_page.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class FoldReadyPage extends StatefulWidget {
  final RecipeCard recipeCard;

  FoldReadyPage(this.recipeCard);

  @override
  _FoldReadyPageState createState() => _FoldReadyPageState(recipeCard);
}

class _FoldReadyPageState extends State<FoldReadyPage> {

  RecipeCard recipeCard;

  _FoldReadyPageState(RecipeCard _recipeCard) {
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
        title : recipeCard.recipeName,
      ),
      // 2-1. 상세 화면 (전체 화면 세팅1)
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        progressIndicator: CircularProgressIndicator(),
        opacity: 0.1,
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FractionallySizedBox(
                                    widthFactor: 2/7,
                                    child: Image.network('${IP.address}/img/image/${recipeCard.recipeName}.png')),
                                SizedBox(height : 25),
                                buildRarityBox(recipeCard.rarity),
                                SizedBox(height : 10),
                                Text(recipeCard.recipeName, style: TextStyle(fontSize: 30, fontFamily: Font.bold),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.star, size : 30, color: primaryColor,),
                                    Icon(Icons.star, size : 30, color: primaryColor,),
                                    Icon(Icons.star, size : 30, color: primaryColor,),
                                    Icon(Icons.star, size : 30, color: primaryColor,),
                                    Icon(Icons.star, size : 30, color: primaryColor,)
                                  ],
                                )

                              ],
                            ),
                          ),
                          
                          Container(
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.bottomLeft,
                            child: Text("준비물", style: TextStyle(fontFamily: Font.bold, fontSize: 16),),
                          )
                          
                        ]
                      ),
                    ),
                    Flexible(
                      flex : 3,
                      child: Container(
                        width: double.infinity,
                        color : navColor,
                        child : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: primaryColor,
                              width : 50,
                              height : 50,
                            ),
                            SizedBox(height: 10,),
                            Text("색종이", style: TextStyle(fontSize: 20, fontFamily: Font.bold),)
                          ],
                        )
                      )
                    )
                  ],
                )
              ),
              Material(
                color: primaryColor,
                child: InkWell(
                  onTap: () {goFoldPage(recipeCard);},
                  child: Container(
                    height : 70,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.network('${IP.localAddress}/img/image/fold.png'),
                        SizedBox(width: 6,),
                        Text("접기", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ),
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
