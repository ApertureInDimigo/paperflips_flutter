import 'dart:io';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './common/color.dart';
import './common/font.dart';
import './common/asset_path.dart';
import 'package:http/http.dart' as http;
import './common/data_class.dart';
import 'common/auth.dart';

class IntroducePage extends StatefulWidget {
  final RecipeCard recipeCard;

  IntroducePage(this.recipeCard);

  @override
  _IntroducePageState createState() => _IntroducePageState(recipeCard);
}

class _IntroducePageState extends State<IntroducePage> {
  RecipeCard recipeCard;

  _IntroducePageState(RecipeCard _recipeCard) {
    recipeCard = _recipeCard;
  }

  String dirname;
  static String videoURL = "https://www.youtube.com/watch?v=qG7LPf5n5MQ";


  String _imagePath;
  String _videoUrl;
  String _description;

  getIntroduceInfo() async{
    final res = await http.get(
        "https://paperflips-server.herokuapp.com/rec/GetDetail/${recipeCard.recipeName}",
        headers: {"Cookie" : "user=" + await getToken()}
    );
  }




  YoutubePlayerController _controller;

  @override
  void initState() async {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoURL),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

//  _IntroducePageState() {
//    dirname = "172.31.99.194";   //CMD창에 ipconfig 쳐보고 자기 Ipv4 주소 적어서 해보세요..
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FractionallySizedBox(
            child: Text("\"학\" 소개",
                style: TextStyle(fontSize: 18, fontFamily: Font.bold))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('images/test.jpg'),
            Container(
              margin: EdgeInsets.only(
                  top: 25.0, right: 20.0, bottom: 12.5, left: 20.0),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            ),
            Container(
                width: 450,
//              height: 250,
                margin: EdgeInsets.only(
                    top: 12.5, right: 20.0, bottom: 25.0, left: 20.0),
                child: _buildIntroduceText(
                    "<<학>>은 두루미라는 또 다른 이름을 갖고 있어요. 학은 다른 동물에 비해 적은 수만 존재하기 때문에 국가에서 <<천연기념물>>로 지정하여 보호하고 있어요. 학은 추운 지방에서 살기 때문에, 여름에는 북쪽으로 이동해요. 학은 우리나라에서 <<고귀한 성품>>과 <<장수>>를 상징하는 대표적 존재로 인식됐어요. 따라서 학과 관련된 예술 공예품과 시가 많이 있답니다. 흰 저고리에 검은 치마를 입은 학이 하악 하악 하악하고 웁니다. 이것을 사자성어로 <<호의현상>> 이라고 합니다. 송강 정철이 쓴 관동별곡에 나와있습니다. 어린이 여러분들은 관동별곡을 열심히 공부하여 좋은 대학에 진학하셨으면 좋겠습니다."
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduceText(text) {
    String startTag = "<<";
    String endTag = ">>";

    var t1 = text.split(startTag);

    var parsed = [];
    for (var k in t1) {
      if (k.contains(endTag)) {
        parsed.add({"text": k.split(endTag)[0], "isBold": true});
        parsed.add({"text": k.split(endTag)[1], "isBold": false});
      } else {
        parsed.add({"text": k, "isBold": false});
      }
    }

    return RichText(
      text: TextSpan(
          style: TextStyle(
              color: Colors.black, fontSize: 21, fontFamily: Font.normal),
          children: parsed.map<TextSpan>((x) {
            var temp;
            if (x["isBold"] == true) {
              temp = TextSpan(
                text: x["text"],
                style: TextStyle(
                  fontFamily: Font.bold,
                  fontSize: 25,
                ),
              );
            } else {
              temp = TextSpan(text: x["text"]);
            }
            return temp;
          }).toList()),
    );

    List<TextSpan> _buildTextSpan(text) {
      if (text.contains("<b>")) {}
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 21),
        children: _buildTextSpan(text),
      ),
    );
  }
}
