import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/collection_page.dart';
import 'package:flutter_front/common/auth.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'common/color.dart';
import 'common/data_class.dart';
import 'dart:core';
import 'package:glitters/glitters.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FoldCompletePage extends StatefulWidget {
  final RecipeCard recipeCard;

  FoldCompletePage(this.recipeCard);

  @override
  _FoldCompletePageState createState() => _FoldCompletePageState(recipeCard);
}

class _FoldCompletePageState extends State<FoldCompletePage> {
  RecipeCard recipeCard;

  _FoldCompletePageState(RecipeCard _recipeCard) {
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
    Widget _buildCompletePage() {
      return Container(
        color: Colors.white,
        child: Center(
            child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                children: [
                  Center(child: Image.network(recipeCard.path)),
                  Glitters(
                    minSize: 25,
                    maxSize: 40,
                    interval: Duration(milliseconds: 100),
                    maxOpacity: 0.9,
                    color: Colors.orange,
                  ),
                  Glitters(
                    minSize: 25,
                    maxSize: 40,
                    duration: Duration(milliseconds: 200),
                    outDuration: Duration(milliseconds: 500),
                    interval: Duration.zero,
                    color: Colors.green,
                    maxOpacity: 0.7,
                  ),
                  Glitters(
                    minSize: 25,
                    maxSize: 40,
                    interval: Duration(milliseconds: 100),
                    maxOpacity: 0.9,
                    color: Colors.yellowAccent,
                  ),
                  Glitters(
                    minSize: 25,
                    maxSize: 40,
                    duration: Duration(milliseconds: 200),
                    outDuration: Duration(milliseconds: 500),
                    interval: Duration.zero,
                    color: Colors.white,
                    maxOpacity: 0.7,
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 80),
                child: Text(
                  recipeCard.recipeName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 48,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            Material(
              color: primaryColor,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(100), right: Radius.circular(100)),
              child: InkWell(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(100), right: Radius.circular(100)),
                onTap: () async {
                  setState(() {
                    _inAsyncCall = true;
                  });
                  var token = await getToken();

                  if (token == null || token == "") {
                    setState(() {
                      _inAsyncCall = false;
                    });
                    Navigator.of(context).popUntil((route) => route.isFirst);

                    return;
                  } else {
                    final res = await http.get(
                        "https://paperflips.com/User/GetCollection",
                        headers: {"Cookie": "user=" + await getToken()});
                    print(res.headers);

                    if (res.statusCode == 200) {
                      Map<String, dynamic> resData = jsonDecode(res.body);
                      var data = resData["data"];
                      print(data);
                      if (data == null) {
                        setState(() {
                          _inAsyncCall = false;
                        });
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        return null;
                      }

                      for (var collection in data) {
                        if (collection["seq"] == recipeCard.recipeSeq) {
                          setState(() {
                            _inAsyncCall = false;
                          });
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          return;
                        }
                      }
                      print("add");
                      final res2 = await http.post(
                          "https://paperflips.com/User/AddCollection/${recipeCard.recipeSeq}",
                          headers: {"Cookie": "user=" + await getToken()});
                      print(res2.headers);

                      setState(() {
                        _inAsyncCall = false;
                      });
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.push(
                        context,
                        FadeRoute(page: CollectionPage()),
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(100),
                        right: Radius.circular(100)),
                  ),
                  width: 250,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Center(
                      child: Text(
                    '완성',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )),
      );
    }

    return Scaffold(
        appBar: DefaultAppBar(title: "완성!"),
        body: ModalProgressHUD(
          inAsyncCall: _inAsyncCall,
          progressIndicator: CircularProgressIndicator(),
          opacity: 0.1,
          child: _buildCompletePage(),
        ));
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
