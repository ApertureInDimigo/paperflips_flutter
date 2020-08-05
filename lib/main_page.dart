import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/search_page.dart';
import './common/color.dart';
import './common/font.dart';
import './common/asset_path.dart';
import 'common/widgets/appbar.dart';
import 'common/widgets/recipe_card.dart';
import 'common/data_class.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildDefaultAppbar(),
        body: Column(
          children: <Widget>[
            _buildUpperMenu(), //앱바 아래 메뉴까지
            _buildBottomMenu(), //MVP 카드 추천 종이접기
            _buildSearchBar(), //클릭 시 검색바 열림림
          ],
        ));
  }

  Widget _buildBottomMenu() {
    return Flexible(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8),
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
      ),
    );
  }

  Widget _buildSearchBar() {
    return Hero(
      tag: "searchBar",
      child: Container(
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
                child: Material(
              color: cardColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                onTap: () {
                  goSearchPage();
                },
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
//                          color: cardColor,
//                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("원하시는 종이접기를 검색하여 찾아보세요"),
                  ),
                ]),
              ),
            )),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                      padding: EdgeInsets.all(3), child: Icon(Icons.search)),
                  onTap: () {
                    goSearchPage();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMVPCard() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            )
          ]),
      child: Material(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: () {},
//          splashColor: Colors.white,
          child: Container(
//            margin: EdgeInsets.only(top: 5),
              height: 90,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: 10, right: 20, top: 20, bottom: 20),
                    child: Image.asset(IconPath.boat),
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
                            style:
                                TextStyle(fontFamily: Font.bold, fontSize: 12),
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
    return Column(
      children: [
        RecipeCard(
            recipeName: "코끼리",
            rarity: "rare",
            iconPath: IconPath.elephant,
            summary: "배경을 클릭해 코끼리의 소개를 들어봐요!"),
        RecipeCard(
            recipeName: "종이이배",
            rarity: "normal",
            iconPath: IconPath.boat,
            summary: "배경을 클릭해 종이이배의 소개를 들어봐요!"),
        RecipeCard(
            recipeName: "코코끼리",
            rarity: "legend",
            iconPath: IconPath.elephant,
            summary: "배경을 클릭해 코코끼리의 소개를 들어봐요!"),
        RecipeCard(
            recipeName: "P",
            rarity: "rare",
            iconPath: IconPath.letter_p,
            summary: "배경을 클릭해 P의 소개를 들어봐요!"),
        RecipeCard(
            recipeName: "종이배",
            rarity: "normal",
            iconPath: IconPath.boat,
            summary: "배경을 클릭해 종이배의 소개를 들어봐요!"),
      ].map((x) => buildRecipeCard(x)).toList(),
    );
  }

  //검색 페이지로 이동
  void goSearchPage() {
    Navigator.push(
      context,
      FadeRoute(page: SearchPage()),
    );
  }
}

//페이지 이동 디졸브 트랜지션
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
