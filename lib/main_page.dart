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
        body: Column(
          children: <Widget>[
            _buildUpperMenu(),
            _buildBottomMenu(),
            _buildSearchBar(),
          ],
        ));
  }

  Widget _buildBottomMenu() {
    return Flexible(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "7월 MVP",
                  style: TextStyle(
                      fontSize: 22,
//                  fontWeight: FontWeight.bold,
                      fontFamily: Font.extraBold),
                ),
              ),
              SizedBox(height: 5),
              _buildMVPCard(),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "추천 종이접기",
                  style: TextStyle(
                      fontSize: 22,
//                  fontWeight: FontWeight.bold,
                      fontFamily: Font.extraBold),
                ),
              ),
              SizedBox(height: 10),
              _buildRecommendRecipeList(),
            ],
          )),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, -1), // changes position of shadow
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: cardColor,
//                    focusColor: Colors.grey,

                hintText: "원하는 종이접기 안내서를 이곳에서 검색하여 찾아보세요",
                hintStyle: TextStyle(fontSize: 13, color: Colors.black),
              ),
            ),
          ),
          InkWell(
            child: Container(
                padding: EdgeInsets.only(left: 10), child: Icon(Icons.search)),
            onTap: () {
              print("SFD");
            },
          )
        ],
      ),
    );
  }

  Widget _buildMVPCard() {
    return Material(
      color: primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: () {},
        splashColor: Colors.white,
        child: Container(
//            margin: EdgeInsets.only(top: 5),
            height: 90,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
//              color: primaryColor,
//              borderRadius: BorderRadius.all(Radius.circular(20)),
//                boxShadow: [
//                  BoxShadow(
//                    color: Colors.grey.withOpacity(0.4),
//                    spreadRadius: 1,
//                    blurRadius: 1,
//                    offset: Offset(2, 2), // changes position of shadow
//                  )
//                ]
                ),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 10, right: 20, top: 20, bottom: 20),
                  child:
                      Image.network("http://172.31.99.194:3000/image/boat.png"),
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "김수한무님의",
                          style: TextStyle(fontFamily: Font.bold, fontSize: 12),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 2),
                        Text("종이배",
                            style: TextStyle(
                              fontFamily: Font.extraBold,
                              fontSize: 23,
                            ),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 12, right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("클릭하여 구경해보세요",
                                style: TextStyle(
                                    fontSize: 13, fontFamily: Font.bold)),
                            Icon(
                              Icons.arrow_forward,
                              size: 13,
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }

  Widget _buildUpperMenu() {
    return Container(
      padding: EdgeInsets.only(bottom: 8, top: 8),
      decoration: BoxDecoration(
        color: navColor,
      ),
      height: 60,
      child: Row(
        children: ["레시피공유", "방 꾸미기", "스토리모드", "커뮤니티"]
            .map(
              (x) => Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
//                    border: Border.all(width: 0.1),
                        ),
                    child: Column(
                      children: <Widget>[
//                      SizedBox(height: 1),
                        Flexible(
                          child: Image.asset(IconPath.letter_p),
                        ),
                        SizedBox(height: 2),
                        Text(
                          x,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  )),
            )
            .toList(),
      ),
    );
  }

  Widget _buildRecommendRecipeList() {
    return Flexible(
      child: ListView(
        children: [
          {
            "recipeName": "코끼리",
            "rarity": "rare",
            "iconPath": IconPath.elephant,
            "summary": "배경을 클릭해 코끼리의 소개를 들어봐요!"
          },
          {
            "recipeName": "코끼",
            "rarity": "legend",
            "iconPath": IconPath.elephant,
            "summary": "배경을 클릭해 코끼의 소개를 들어봐요!"
          },
          {
            "recipeName": "종이배",
            "rarity": "normal",
            "iconPath": IconPath.boat,
            "summary": "배경을 클릭해 종이배의 소개를 들어봐요!"
          },
          {
            "recipeName": "종이배",
            "rarity": "normal",
            "iconPath": IconPath.boat,
            "summary": "배경을 클릭해 종이의 소개를 들어봐요!"
          },
          {
            "recipeName": "P",
            "rarity": "legend",
            "iconPath": IconPath.boat,
            "summary": "배경을 클릭해 P의 소개를 들어봐요!"
          }
        ].map((x) => _buildRecommendRecipe(x)).toList(),
      ),
    );
  }

  Widget _buildRarityText(String rarity) {
    switch (rarity) {
      case "normal":
        return Text(
          "보통",
          style: TextStyle(color: normalRecipeColor, fontFamily: Font.bold),
          textAlign: TextAlign.left,
        );
      case "rare":
        return Text(
          "희귀",
          style: TextStyle(color: rareRecipeColor, fontFamily: Font.bold),
          textAlign: TextAlign.left,
        );

      case "legend":
        return Text(
          "전설",
          style: TextStyle(color: legendRecipeColor, fontFamily: Font.bold),
          textAlign: TextAlign.left,
        );
    }
  }

  Widget _buildRecommendRecipe(recipe) {
    return Container(
        margin: EdgeInsets.only(top: 5),
        height: 100,
        decoration: BoxDecoration(
          color: cardColor,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 90,
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 20),
              child: Image.network("http://" + dirname + ":3000" + recipe["iconPath"] + ".png"),
            ),
            Flexible(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildRarityText(recipe["rarity"]),
                    Text(recipe["recipeName"],
                        style: TextStyle(
                          fontFamily: Font.bold,
                          fontSize: 23,
                        ),
                        textAlign: TextAlign.left),
                    Text(recipe["summary"], style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(color: primaryColor),
                width: 50,
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 12, right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(IconPath.fold),
                    SizedBox(height: 3),
                    Text("접기", style: TextStyle(fontSize: 12))
                  ],
                ))
          ],
        ));
  }
}
