import 'dart:io';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './common/color.dart';
import './common/font.dart';
import './common/asset_path.dart';

class IntroducePage extends StatefulWidget {
  @override
  _IntroducePageState createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> {

  String dirname;
  static String videoURL = "https://www.youtube.com/watch?v=qG7LPf5n5MQ";

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoURL),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  _IntroducePageState() {
    dirname = "172.31.99.194";   //CMD창에 ipconfig 쳐보고 자기 Ipv4 주소 적어서 해보세요..
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FractionallySizedBox(
              child: Text("\"학\" 소개",
                style: TextStyle(fontSize: 18, fontFamily: Font.bold))
          ),
        ),
      body: Column(
        children: <Widget>[
          Image.asset('images/test.jpg'),
          Container(
            margin: EdgeInsets.only(top: 25.0, right: 20.0, bottom: 12.5, left: 20.0),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
          Container(
            width: 450,
            height: 250,
            margin: EdgeInsets.only(top: 12.5, right: 20.0, bottom: 25.0, left: 20.0),
            child: Text("학은 두루미라는 또 다른 이름을 갖고 있어요. 학은 다른 동물에 비해 적은 수만 존재하기 때문에 국가에서 천연기념물로 지정하여 보호하고 있어요. 학은 추운 지방에서 살기 때문에, 여름에는 북쪽으로 이동해요. 학은 우리나라에서 고귀한 성품과 장수를 상징하는 대표적 존재로 인식됐어요. 따라서 학과 관련된 예술 공예품과 시가 많이 있답니다.",
              style: TextStyle(
                fontSize: 20,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

