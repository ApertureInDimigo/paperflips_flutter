import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/appbar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'common/color.dart';
import 'common/data_class.dart';
import 'dart:core';

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
                child: Container(
                  child: Center(
                    child: Text(recipeCard.recipeName + "ㅋㅋ루삥뿡"),
                  ),
                ),
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
        FoldProcess(subtitleExplainText: "동해물과 백두산이", ttsExplainText: "동해물과 백두산이"),
        FoldProcess(subtitleExplainText: "마르고 닳도록", ttsExplainText: "마르고 닳도록"),
        FoldProcess(subtitleExplainText: "하느님이 보우하사", ttsExplainText: "하느님이 보우하사"),
        FoldProcess(subtitleExplainText: "우리나라 만세", ttsExplainText: "우리나라 만세"),
        FoldProcess(subtitleExplainText: "무궁화 삼천리", ttsExplainText: "무궁화 삼천리"),
        FoldProcess(subtitleExplainText: "화려강산", ttsExplainText: "화려강산"),
        FoldProcess(subtitleExplainText: "대한사람 대한으로", ttsExplainText: "대한사람 대한으로"),
        FoldProcess(subtitleExplainText: "길이 보전하세", ttsExplainText: "길이 보전하세"),
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
