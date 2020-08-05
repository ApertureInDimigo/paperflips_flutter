import 'package:flutter/material.dart';
import './common/font.dart';
import './common/color.dart';
import './common/asset_path.dart';
import 'main_page.dart';
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
        leading: Icon(
          Icons.arrow_back,
          size: 30,
        ),
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
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 25.0),
      child: GridView.count(
        scrollDirection: Axis.vertical, //스크롤 방향 조절
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2, //로우 혹은 컬럼수 조절 (필수값)
        children: [
          {
            "collectionName": "코끼리",
            "rarity": "rare",
            "iconPath": IconPath.elephant,
            "obtainDate": "2020/06/29"
          },
          {
            "collectionName": "종이배",
            "rarity": "normal",
            "iconPath": IconPath.boat,
            "obtainDate": "2020/05/21"
          },
          {
            "collectionName": "코끼",
            "rarity": "legend",
            "iconPath": IconPath.elephant,
            "obtainDate": "2020/08/04"
          },
          {
            "collectionName": "황금개구리",
            "rarity": "limited",
            "iconPath": IconPath.golden_frog,
            "obtainDate": "2020/07/21"
          },
          {
            "collectionName": "종이배",
            "rarity": "normal",
            "iconPath": IconPath.boat,
            "obtainDate": "2020/05/21"
          },
          {
            "collectionName": "코끼리",
            "rarity": "rare",
            "iconPath": IconPath.elephant,
            "obtainDate": "2020/06/29"
          },
          {
            "collectionName": "코끼리",
            "rarity": "rare",
            "iconPath": IconPath.elephant,
            "obtainDate": "2020/06/29"
          },
          {
            "collectionName": "코끼",
            "rarity": "legend",
            "iconPath": IconPath.elephant,
            "obtainDate": "2020/08/04"
          },
          {
            "collectionName": "종이배",
            "rarity": "normal",
            "iconPath": IconPath.boat,
            "obtainDate": "2020/05/21"
          },
          {
            "collectionName": "코끼",
            "rarity": "legend",
            "iconPath": IconPath.elephant,
            "obtainDate": "2020/08/04"
          },
        ].map((x) => _collectionCard(x)).toList(),
      ),
    ),
  );
}

Widget _collectionCard(collection) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      decoration: BoxDecoration(
        color: collectionContainerColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Image.network(
            "http://" + IP.address + ":3000" + collection["iconPath"] + '.png',
            width: 80,
            height: 80
          ),
          _rarityBox(collection["rarity"]),
          Text(
            collection["collectionName"],
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.normal,
              fontFamily: Font.bold,
            ),
          ),
          Text(
            collection["obtainDate"],
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              fontFamily: Font.normal,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _rarityBox(String rarity) {
  switch (rarity) {
    case "normal":
      return Container(
        width: 45,
        height: 25,
        decoration: BoxDecoration(
          color: normalRecipeColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            "보통",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: Font.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    case "rare":
      return Container(
        width: 45,
        height: 25,
        decoration: BoxDecoration(
          color: rareRecipeColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            "희귀",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: Font.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    case "legend":
      return Container(
        width: 45,
        height: 25,
        decoration: BoxDecoration(
          color: legendRecipeColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            "전설",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: Font.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    case "limited":
      return Container(
        width: 45,
        height: 25,
        decoration: BoxDecoration(
          color: limitedRecipeColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            "한정",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: Font.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
  }
}
