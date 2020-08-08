import 'package:flutter/material.dart';
import 'package:flutter_front/size.dart';
import '../../common/color.dart';
import '../../common/font.dart';
import '../../common/asset_path.dart';
import '../../common/data_class.dart';
import '../../common/ip.dart';
import 'package:intl/intl.dart';
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
                      child: Image.network('${IP.address}/img/image/${recipe.recipeName}.png'/*recipe.iconPath*/),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildRarityText(recipe.rarity),
                            Container(height: 2),
                            Text(recipe.recipeName,
                                style: TextStyle(
                                  fontFamily: Font.bold,
                                  fontSize: 23,
                                ),
                                textAlign: TextAlign.left),
                            Container(height: 4),
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


Widget _buildRarityBox(String rarity) {
  Widget rarityBoxWidget;
  switch (rarity) {
    case "normal":
      rarityBoxWidget = Container(
        width: 40,
        height: 24,
        decoration: BoxDecoration(
          color: normalRecipeColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            "보통",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: Font.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
      break;
    case "rare":
      rarityBoxWidget = Container(
        width: 40,
        height: 24,
        decoration: BoxDecoration(
          color: rareRecipeColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            "희귀",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: Font.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
      break;
    case "legend":
      rarityBoxWidget = Container(
        width: 40,
        height: 24,
        decoration: BoxDecoration(
          color: legendRecipeColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            "전설",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: Font.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
      break;
    case "limited":
      rarityBoxWidget = Container(
        width: 40,
        height: 24,
        decoration: BoxDecoration(
          color: limitedRecipeColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            "한정",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: Font.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
      break;
  }
  return rarityBoxWidget;
}

Widget buildRecipeCollection(collection) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 0.5,
          blurRadius: 1,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Material(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      color: collectionContainerColor,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(

              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Image.network(
                    collection.iconPath,
                    width: 80,
                    height: 80
                ),
                _buildRarityBox(collection.rarity),
                SizedBox(height: 3),
                Text(
                  collection.recipeName,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    fontFamily: Font.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  DateFormat('yyyy/MM/dd').format(collection.obtainDate),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: Font.normal,
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


