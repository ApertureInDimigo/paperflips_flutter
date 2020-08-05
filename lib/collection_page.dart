import 'package:flutter/material.dart';
import './common/font.dart';
import './common/color.dart';
import './common/asset_path.dart';
import 'main_page.dart';
import './common/data_class.dart';
import './common/widgets/recipe_card.dart';
import './common/ip.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: collectionContainerColor,
        elevation: 0.0,
// 새 페이지가 열릴 때 자동으로 화살표 버튼이 생기는 것 같아서 임시로 일단 지웠어요
//        leading: Icon(
//          Icons.arrow_back,
//          size: 30,
//        ),
        centerTitle: true,
        title: Text(
          "내 컬렉션",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, fontFamily: Font.bold),
        ),
      ),
      body: _buildCollectionMenu(),
    );
  }
}

Widget _buildCollectionMenu() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15.0),
      child: GridView.count(
        scrollDirection: Axis.vertical,
        //스크롤 방향 조절
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        //로우 혹은 컬럼수 조절 (필수값)
        children: [
//          {
//            "collectionName": "코끼리",
//            "rarity": "rare",
//            "iconPath": IconPath.elephant,
//            "obtainDate": "2020/06/29"
//          },
          RecipeCard(
              recipeName: "코끼리",
              rarity: "rare",
              iconPath: IconPath.elephant,
              obtainDate: DateTime(2015, 8, 7)),
          RecipeCard(
              recipeName: "코끼리ㅋ",
              rarity: "legend",
              iconPath: IconPath.elephant,
              obtainDate: DateTime(2015, 12, 7)),
          RecipeCard(
              recipeName: "코끼리",
              rarity: "rare",
              iconPath: IconPath.elephant,
              obtainDate: DateTime(2015, 8, 7)),
          RecipeCard(
              recipeName: "코끼리",
              rarity: "rare",
              iconPath: IconPath.elephant,
              obtainDate: DateTime(2015, 8, 7)),
          RecipeCard(
              recipeName: "코끼리",
              rarity: "rare",
              iconPath: IconPath.elephant,
              obtainDate: DateTime(2015, 8, 7)),
          RecipeCard(
              recipeName: "코끼리",
              rarity: "rare",
              iconPath: IconPath.elephant,
              obtainDate: DateTime(2015, 8, 7)),
          RecipeCard(
              recipeName: "코끼리",
              rarity: "rare",
              iconPath: IconPath.elephant,
              obtainDate: DateTime(2015, 8, 7)),
          RecipeCard(
              recipeName: "코끼리",
              rarity: "rare",
              iconPath: IconPath.elephant,
              obtainDate: DateTime(2015, 8, 7)),
          RecipeCard(
              recipeName: "코끼리",
              rarity: "rare",
              iconPath: IconPath.elephant,
              obtainDate: DateTime(2015, 8, 7)),
        ].map((x) => buildRecipeCollection(x)).toList(),
      ),
    ),
  );
}
