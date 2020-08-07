import 'package:flutter/material.dart';
import './common/font.dart';
import './common/color.dart';
import './common/asset_path.dart';
import 'main_page.dart';
import './common/data_class.dart';
import './common/widgets/recipe_card.dart';
import './common/ip.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  bool _inAsyncCall;
  List<RecipeCard> _collectionList = [];

  @override
  void initState() {
    super.initState();
    _collectionList = [];
    _inAsyncCall = false;
    getRecipeCollectionData();
  }

  Future getRecipeCollectionData() async {
    setState(() {
      _collectionList = [];
      _inAsyncCall = true;
    });
    final res = await http.get(
      "http://coronawith.me/",
    );
    List<RecipeCard> collectionList = [1,2,3,4,5,6,7,8,9,10].map((x) {
      var rng = new Random();
      int rndInt = rng.nextInt(1000);
      return RecipeCard(
          recipeName: "코끼리${x}",
          rarity: rndInt % 4 == 0 ? "normal" : rndInt % 4 == 1 ? "rare" : rndInt % 4 == 2 ? "legend" : "limited",
          summary : "SFDA"
          );
    }).toList();
//    print(collectionList);
    setState(() {
      _collectionList = collectionList;
      _inAsyncCall = false;
    });
    return null;
  }

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
      body: ModalProgressHUD(
          inAsyncCall : _inAsyncCall,
          progressIndicator: CircularProgressIndicator(),
          opacity: 0,
          child: _buildCollectionMenu()),
    );
  }

  Widget _buildCollectionMenu() {
//    print(_collectionList);
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
          children:
              _collectionList.map((x) => buildRecipeCollection(x)).toList(),
        ),
      ),
    );
  }
}
