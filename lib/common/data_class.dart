import 'package:flutter_front/request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ip.dart';

import 'package:flutter/material.dart';




//import 'package:json_annotation/json_annotation.dart'; //이건 어떻게 쓸 지 모르겠어요.. 일단 기존 방법을 택할게요..ㅠㅠ

//이 파일에 json 파싱 등을 위한 데이터 클래스를 정의할 것

//레시피 카드(메인 화면, 검색 화면)

class Sticker {
  int id;
  String name;
  String path;
  int limit;
  int count;

  Sticker({this.id, this.name, this.path, this.limit, this.count});
}









class CollectionCard {
  List<RecipeCard> rec;
  List<DateTime> obtainDate;
  String path;

  addCol(RecipeCard r, DateTime obtain) {
    rec.add(r);
    obtainDate.add(obtain);
  }
}


class FoldProcess {

  String imgPath;

  String subtitleExplainText;
  String ttsExplainText;

  FoldProcess({this.imgPath, this.subtitleExplainText, this.ttsExplainText});
}



class BackgroundColor {
  int id;
  String kind;
  String name;
  Color color;
  int price;
  BoxDecoration decoration;
  bool isAvailable;

  BackgroundColor({int id, String kind, String name, Color color, int price, BoxDecoration decoration, bool isAvailable}) {
    this.id = id;
    this.kind = kind;
    this.name = name;
    if (price != null) {
      this.price = price;
    } else {
      this.price = null;
    }

    if (color != null) {
      this.color = color;
    } else {
      this.color = null;
    }
    if (decoration != null) {
      this.decoration = decoration;
    } else {
      this.decoration = null;
    }

    this.isAvailable = isAvailable;
  }
}

class RecipeCard {

  int recipeSeq;
  String recipeName;
  String rarity;
  String summary;
  String path;
  String date;


  RecipeCard({this.recipeSeq, this.recipeName, this.rarity, this.summary, this.path, this.date = ""});

  RecipeCard.fromJson(Map<String, dynamic> json) {
    recipeSeq = json["seq"];
    recipeName = json['recipeName'];
    rarity = json['rarity'];
//    path = json["path"];
    path = "https://paperflips.s3.amazonaws.com/recipe_img/${json["seq"]}.png";

    summary = json['summary'];

    date = json["Date"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["seq"] = this.recipeSeq;
    data['rarity'] = this.rarity;
    data['summary'] = this.summary;
    data["path"] = this.path;
    return data;
  }
}

class GetRecipeCard{
  static Future<RecipeCard> fetchPost(int n) async {
    final response = await http.get('${IP.address}/rec/data/' + n.toString());

    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      return RecipeCard.fromJson(jsonDecode(response.body));
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }
}
