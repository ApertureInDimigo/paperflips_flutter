import 'package:flutter/material.dart';
import '../../common/color.dart';
import '../../common/font.dart';
import '../../common/asset_path.dart';
import '../../common/data_class.dart';

// rarity 를 받고 해당 Text 위젯 반환
// rarity 가 null 일 경우, 빈 Container() 위젯 반환
Widget _buildRarityText(rarity) {
  Widget rarityTextWidget;
  switch (rarity) {
    case "normal":
      rarityTextWidget = Text(
        "보통",
        style: TextStyle(color: normalRecipeColor, fontFamily: Font.bold),
        textAlign: TextAlign.left,

      );
      break;
    case "rare":
      rarityTextWidget = Text(
        "희귀",
        style: TextStyle(color: rareRecipeColor, fontFamily: Font.bold),
        textAlign: TextAlign.left,
      );
      break;

    case "legend":
      rarityTextWidget = Text(
        "전설",
        style: TextStyle(color: legendRecipeColor, fontFamily: Font.bold),
        textAlign: TextAlign.left,
      );
      break;

    default:
      rarityTextWidget = Container();
      break;
  }
  return rarityTextWidget;
}

// RecipeCard 클래스를 받아 메인 페이지, 검색 페이지 등에 쓰일 레시피 카드 반환
Widget buildRecipeCard(RecipeCard recipe) {
  return Container(
      margin: EdgeInsets.only(top: 5),
      height: 100,
      decoration: BoxDecoration(
        color: cardColor,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Material(
              color: cardColor,
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 90,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: 20, right: 15, top: 20, bottom: 20),
                      child: Image.asset(recipe.iconPath),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildRarityText(recipe.rarity),
                            Text(recipe.recipeName,
                                style: TextStyle(
                                  fontFamily: Font.bold,
                                  fontSize: 23,
                                ),
                                textAlign: TextAlign.left),
                            Text(recipe.summary,
                                style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: primaryColor,
            child: InkWell(
//                splashColor: Colors.white,
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(),
                  width: 50,
                  padding: EdgeInsets.only(
                      top: 15, bottom: 15, left: 12, right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(IconPath.fold),
                      SizedBox(height: 3),
                      Text("접기", style: TextStyle(fontSize: 12))
                    ],
                  )),
            ),
          )
        ],
      ));
}