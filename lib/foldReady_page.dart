import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/appbar.dart';
import 'package:flutter_front/common/widgets/dialog.dart';
import 'package:flutter_front/common/widgets/recipe_card.dart';
import 'common/asset_path.dart';
import 'common/color.dart';
import 'common/data_class.dart';
import 'dart:core';
import 'common/font.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          title: recipeCard.recipeName,
        ),
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
                    child: Stack(children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FractionallySizedBox(
                                widthFactor: 2 / 7,
                                child: Image.network(recipeCard.path)),
                            SizedBox(height: 25),
                            buildRarityBox(recipeCard.rarity),
                            SizedBox(height: 10),
                            Text(
                              recipeCard.recipeName,
                              style: TextStyle(
                                  fontSize: 30, fontFamily: Font.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 30,
                                  color: primaryColor,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 30,
                                  color: primaryColor,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 30,
                                  color: primaryColor,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 30,
                                  color: primaryColor,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 30,
                                  color: primaryColor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "?????????",
                          style: TextStyle(fontFamily: Font.bold, fontSize: 16),
                        ),
                      )
                    ]),
                  ),
                  Flexible(
                      flex: 3,
                      child: Container(
                          width: double.infinity,
                          color: navColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                color: primaryColor,
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "?????????",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: Font.bold),
                              )
                            ],
                          )))
                ],
              )),
              Material(
                color: primaryColor,
                child: InkWell(
                  onTap: () {
                    goFoldPage(recipeCard);
                  },
                  child: Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(IconPath.fold),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "??????",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        ));
  }

  void goFoldPage(recipeCard) async {
    if (recipeCard.recipeName != "???") {
      showCustomDialog(
          context: context,
          title: "??????????????????.",
          content: "??? ???????????????!",
          confirmButtonText: "??????",
          confirmButtonAction: () async {
            print("SD");

            Navigator.pop(context);
          });
      return;
    }

    setState(() {
      _inAsyncCall = true;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _inAsyncCall = false;
    });
    Navigator.push(
      context,
      FadeRoute(
          page: FoldPage(recipeCard, [
        FoldProcess(
            imgPath: "http://dimigo.herokuapp.com/paperflips/image/1",
            subtitleExplainText: "???????????? ????????????",
            ttsExplainText: "????????? ??????????????? ????????? ???????????????"),
        FoldProcess(
            imgPath: "http://dimigo.herokuapp.com/paperflips/image/2",
            subtitleExplainText: "????????? ?????????",
            ttsExplainText: "????????? ????????? ?????? ??? ??? ????????? ???????????? ???????????????"),
        FoldProcess(
            imgPath: "http://dimigo.herokuapp.com/paperflips/image/3",
            subtitleExplainText: "???????????? ????????????",
            ttsExplainText: "????????? ?????? ?????? ???????????????"),
        FoldProcess(
            imgPath: "http://dimigo.herokuapp.com/paperflips/image/4",
            subtitleExplainText: "???????????? ??????",
            ttsExplainText: "????????? ?????? ?????? ???????????????"),
        FoldProcess(
            imgPath: "http://dimigo.herokuapp.com/paperflips/image/5",
            subtitleExplainText: "????????? ?????????",
            ttsExplainText: "????????? ?????? ?????? ???????????????"),
        FoldProcess(
            imgPath: "http://dimigo.herokuapp.com/paperflips/image/6",
            subtitleExplainText: "????????????",
            ttsExplainText: "????????? ?????????"),
        FoldProcess(
            imgPath: "http://dimigo.herokuapp.com/paperflips/image/7",
            subtitleExplainText: "???????????? ????????????",
            ttsExplainText: "????????? ?????? ?????? ???????????????"),
        FoldProcess(
            imgPath: "http://dimigo.herokuapp.com/paperflips/image/8",
            subtitleExplainText: "?????? ????????????",
            ttsExplainText: "?????? ?????? ???????????? ???????????????"),
        FoldProcess(
            imgPath: "http://dimigo.herokuapp.com/paperflips/image/9",
            subtitleExplainText: "?????? ????????????",
            ttsExplainText: "????????? ?????? ??????????????????"),
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
