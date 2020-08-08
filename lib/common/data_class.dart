import 'package:flutter_front/request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ip.dart';
//이 파일에 json 파싱 등을 위한 데이터 클래스를 정의할 것

//레시피 카드(메인 화면, 검색 화면)

class CollectionCard {
  List<RecipeCard> rec;
  List<DateTime> obtainDate;

  addCol(RecipeCard r, DateTime obtain) {
    rec.add(r);
    obtainDate.add(obtain);
  }
}

class RecipeCard {
  String recipeName;
  String rarity;
  String summary;

  RecipeCard({this.recipeName, this.rarity, this.summary});

  RecipeCard.fromJson(Map<String, dynamic> json) {
    recipeName = json['recipeName'];
    rarity = json['rarity'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipeName'] = this.recipeName;
    data['rarity'] = this.rarity;
    data['summary'] = this.summary;

    return data;
  }
}

class GetRecipeCard{
  static Future<RecipeCard> fetchPost(int n) async {
    final response = await http.get('${IP.address}/recipe/' + n.toString());

    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      return RecipeCard.fromJson(json.decode(response.body).toJson());
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }
}
