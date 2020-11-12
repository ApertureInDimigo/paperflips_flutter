import 'dart:convert';
import 'package:flutter/material.dart';
import 'common/auth.dart';
import 'common/provider/otherProvider.dart';
import './common/data_class.dart';
import './common/widgets/recipe_card.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'common/widgets/appbar.dart';
import 'package:provider/provider.dart';

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

    print("!@@@@@@@@@@@@@@@@@@@");

    final res = await http.get(
        "https://paperflips.com/User/GetCollection",
        headers: {"Cookie": "user=" + await getToken()});
    print(res.headers);
    Map<String, dynamic> resData = jsonDecode(res.body);
    var data = resData["data"];

    if (data == null) {
      return null;
    }

    var collectionList =
        data.map<RecipeCard>((x) => RecipeCard.fromJson(x)).toList();
    print(collectionList);
    setState(() {
      _collectionList = collectionList;
      _inAsyncCall = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    OtherStatus otherStatus = Provider.of<OtherStatus>(context);
    return ModalProgressHUD(
      inAsyncCall: otherStatus.isLoading | _inAsyncCall,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: DefaultAppBar(title: "내 컬렉션"),
        body: _buildCollectionMenu(),
      ),
    );
  }

  Widget _buildCollectionMenu() {
//    print(_collectionList);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: GridView.count(
          scrollDirection: Axis.vertical,
          //스크롤 방향 조절
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          crossAxisCount: 2,
          childAspectRatio: 9 / 10,
          //로우 혹은 컬럼수 조절 (필수값)
          children:
              _collectionList.map((x) => buildRecipeCollection(x)).toList(),
        ),
      ),
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
