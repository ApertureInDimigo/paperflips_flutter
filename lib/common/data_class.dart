//이 파일에 json 파싱 등을 위한 데이터 클래스를 정의할 것

//레시피 카드(메인 화면, 검색 화면)
class RecipeCard {
  String recipeName;
  String rarity;
  String iconPath;
  String summary;

  RecipeCard({this.recipeName, this.rarity, this.iconPath, this.summary});

  RecipeCard.fromJson(Map<String, dynamic> json) {
    recipeName = json['recipeName'];
    rarity = json['rarity'];
    iconPath = json['iconPath'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipeName'] = this.recipeName;
    data['rarity'] = this.rarity;
    data['iconPath'] = this.iconPath;
    data['summary'] = this.summary;
    return data;
  }
}