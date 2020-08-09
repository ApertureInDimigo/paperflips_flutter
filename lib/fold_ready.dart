import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/appbar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'common/data_class.dart';
import 'dart:core';



class FoldReadyPage extends StatefulWidget {
  final RecipeCard recipeCard;

  FoldReadyPage(this.recipeCard);

  @override
  _FoldReadyPageState createState() => _FoldReadyPageState(recipeCard);
}

class _FoldReadyPageState extends State<FoldReadyPage> {

  RecipeCard recipeCard;

  _FoldReadyPageState(RecipeCard _recipeCard) {
    recipeCard = _recipeCard;
  }

  @override
  void initState() {
    super.initState();
//    _getMySongList();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: DefaultAppBar(
        title : recipeCard.recipeName,
      ),
      // 2-1. 상세 화면 (전체 화면 세팅1)
      body: Container(
        child: Center(
          child: Text(
              recipeCard.recipeName + "ㅋㅋ루삥뿡"
          ),
        ),
      )

    );
  }
}
