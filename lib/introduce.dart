import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './common/font.dart';
import './common/data_class.dart';

class IntroducePage extends StatefulWidget {
  final RecipeCard recipeCard;
  var detail;
  IntroducePage(this.recipeCard, this.detail);

  @override
  _IntroducePageState createState() => _IntroducePageState(recipeCard, detail);
}

class _IntroducePageState extends State<IntroducePage> {
  RecipeCard recipeCard;
  var detail;

  _IntroducePageState(RecipeCard _recipeCard, _detail) {
    recipeCard = _recipeCard;
    detail = _detail;
  }

  String dirname;
  String _imagePath = '';
  String _videoUrl;
  String _description = "";

  Future<dynamic> getIntroduceInfo() {
    setState(() {});

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(_videoUrl),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    var resData = detail;
    _imagePath = resData["ImgPath"];
    _videoUrl = resData["VidPath"];
    print(_videoUrl);
    _description = resData["detail"];
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(_videoUrl),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FractionallySizedBox(
            child: Text('"${widget.recipeCard.recipeName}" 소개',
                style: TextStyle(fontSize: 18, fontFamily: Font.bold))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(_imagePath),
            Container(
              margin: EdgeInsets.only(
                  top: 25.0, right: 20.0, bottom: 12.5, left: 20.0),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                  RemainingDuration(),
                ],
              ),
            ),
            Container(
                width: 450,
                margin: EdgeInsets.only(
                    top: 12.5, right: 20.0, bottom: 25.0, left: 20.0),
                child: _buildIntroduceText(_description)),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduceText(text) {
    String startTag = "{{";
    String endTag = "}}";

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
