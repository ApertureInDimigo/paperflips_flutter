import 'dart:convert';
import 'package:flutter_front/common/provider/otherProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'common/widgets/appbar.dart';
import 'common/widgets/recipe_card.dart';
import './common/color.dart';
import './common/font.dart';
import './common/asset_path.dart';
import './common/data_class.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery; //사용자 입력 검색 쿼리
  List<RecipeCard> _officialRecipeList; //공식 레시피 리스트
  List<RecipeCard> _customRecipeList; //커스텀 레시피 리스트
  bool _isGetSearchData; //검색 데이터를 다 불러왔으면 true 아니면 false
  bool _inAsyncCall; //http 요청중이면 true 아니면 false

  @override
  void initState() {
    super.initState();
    _searchQuery = "";
    _officialRecipeList = [];
    _customRecipeList = [];
    _isGetSearchData = false;
    _inAsyncCall = false;
  }

  @override
  Widget build(BuildContext context) {
    OtherStatus otherStatus = Provider.of<OtherStatus>(context);
    return ModalProgressHUD(
        inAsyncCall: otherStatus.isLoading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
          appBar: DefaultAppBar(),
          body: ModalProgressHUD(
            inAsyncCall: _inAsyncCall,
            progressIndicator: CircularProgressIndicator(),
            opacity: 0,
            child: Container(
                child: Column(
              children: <Widget>[
                _buildSearchBar(),
                _buildSearchList(),
              ],
            )),
          ),
        ));
  }

  //공식 레시피 & 나만의 레시피 검색 결과
  Widget _buildSearchList() {
    return Flexible(
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 8),
            children: <Widget>[
              SizedBox(height: 15),
              Visibility(visible: _isGetSearchData, child: _buildOfficialRecipeList()),
              SizedBox(height: 25),
              Visibility(visible: _isGetSearchData, child: _buildCustomRecipeList()),
              SizedBox(height: 15)
            ],
          )),
    );
  }

  Widget _buildOfficialRecipeList() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 5),
          child: Text(
            "공식 레시피",
            style: TextStyle(
                fontSize: 18,
//                  fontWeight: FontWeight.bold,
                fontFamily: Font.extraBold),
          ),
        ),
        SizedBox(height: 15),
        Column(
          children: _officialRecipeList.length != 0
              ? _officialRecipeList.map((x) => buildRecipeCard(x)).toList()
              : [Text("레시피를 찾을 수 없어요.")],
        )
      ],
    );
  }

  Widget _buildCustomRecipeList() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 5),
          child: Text(
            "나만의 레시피",
            style: TextStyle(
                fontSize: 18,
//                  fontWeight: FontWeight.bold,
                fontFamily: Font.extraBold),
          ),
        ),
        SizedBox(height: 15),
        Column(
          children: _customRecipeList.map((x) => buildRecipeCard(x)).toList(),
        )
      ],
    );
  }

  Future getRecipeSearchData(String searchQuery) async {
    setState(() {
      _officialRecipeList = [];
      _customRecipeList = [];
      _isGetSearchData = false;
      _inAsyncCall = true;
    });
    print(searchQuery);
    final res = await http.get(
      "https://paperflips-server.herokuapp.com/rec/Search?q=${searchQuery.trim()}",
    ); //그냥 임의 주소로 http 요청 해둠

    if (res.statusCode != 200) {
      setState(() {
        _officialRecipeList = [];
        _customRecipeList = [];
        _isGetSearchData = false;
        _inAsyncCall = false;
      });
      return;
    }

    Map<String, dynamic> data = jsonDecode(res.body);

    var recipeList = data["data"];
    print(recipeList);

    var officialRecipeList =
        recipeList != null ? recipeList.map<RecipeCard>((x) => RecipeCard.fromJson(x)).toList() : <RecipeCard>[];

//    print(recipe);

//    print(RecipeCard.fromJson(recipe));
//    setState(() {});

//    List<RecipeCard> officialRecipeList = [1, 2, 3, 4, 5]
//        .map((x) => RecipeCard(
//            recipeName: searchQuery,
//            rarity: "rare",
//            summary: "${searchQuery}의 소개 좀 들어보세요"))
//        .toList();

    List<RecipeCard> customRecipeList =
        [6, 7, 8, 9, 10].map((x) => RecipeCard(recipeName: "더미데이터", rarity: "rare", summary: "터미네이터 아님 ㅋㅋ")).toList();

    setState(() {
      _officialRecipeList = officialRecipeList;
      _customRecipeList = customRecipeList;
      _isGetSearchData = true;
      _inAsyncCall = false;
    });

    return null;
  }

  Widget _buildSearchBar() {
    return Hero(
      tag: "searchBar",
      child: Material(
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: TextField(
//                      key: _searchFormKey,
                    onSubmitted: (value) {
                      getRecipeSearchData(value);
                    },
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },

                    autofocus: true,
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

                      hintText: "원하시는 종이접기를 검색하여 찾아보세요",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child:
                        Container(padding: EdgeInsets.only(left: 3, top: 3, bottom: 3, right: 3), child: Icon(Icons.search)),
                    onTap: () async {
                      getRecipeSearchData(_searchQuery);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
