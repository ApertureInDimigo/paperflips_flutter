import 'package:flutter/material.dart';

import 'package:flutter_front/common/data_class.dart';

//Appbar 색상
Map<int, Color> color = {
  50: Color.fromRGBO(210, 210, 210, .1),
  100: Color.fromRGBO(210, 210, 210, .2),
  200: Color.fromRGBO(210, 210, 210, .3),
  300: Color.fromRGBO(210, 210, 210, .4),
  400: Color.fromRGBO(210, 210, 210, .5),
  500: Color.fromRGBO(210, 210, 210, .6),
  600: Color.fromRGBO(210, 210, 210, .7),
  700: Color.fromRGBO(210, 210, 210, .8),
  800: Color.fromRGBO(210, 210, 210, .9),
  900: Color.fromRGBO(210, 210, 210, 1),
};
MaterialColor navColor = MaterialColor(0xFFF1F1F1, color);
Color cardColor = Color(0xFFF3F3F3);

Color normalRecipeColor = Color(0xFF747474);
Color rareRecipeColor = Color(0xFF00AD45);
Color legendRecipeColor = Color(0xFF0048FF);
Color limitedRecipeColor = Color(0xFF0ABFB3);

Color primaryColor = Color(0xFFFFD917);
Color kakaoColor = Color(0xFFFFD814);

Color collectionContainerColor = Color(0xFFF8F8F8);

var roomBackgroundColorList = {
  "빨강": [
    BackgroundColor(
      id: 1,
      kind: "빨강",
      name: "빨강",
      decoration: BoxDecoration(
        color: Color(0xFFeb4034),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 2,
      kind: "빨강",
      name: "분홍",
      decoration: BoxDecoration(
        color: Colors.red[300],
      ),
      isAvailable: true,
    ),
  ],
  "주황": [
    BackgroundColor(
      id: 101,
      kind: "주황",
      name: "주황",
      decoration: BoxDecoration(
        color: Colors.orange,
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 102,
      kind: "주황",
      name: "연주황",
      decoration: BoxDecoration(
        color: Colors.orange[300],
      ),
      isAvailable: true,
    ),
  ],
  "노랑": [
    BackgroundColor(
      id: 201,
      kind: "노랑",
      name: "노랑",
      decoration: BoxDecoration(
        color: Colors.yellow,
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 202,
      kind: "주황",
      name: "연노랑",
      decoration: BoxDecoration(
        color: Colors.yellow[300],
      ),
      isAvailable: true,
    ),
  ],
  "초록": [
    BackgroundColor(
      id: 500,
      kind: "초록",
      name: "녹파스텔",
      decoration: BoxDecoration(
        color: Color(0xFFC2DCC9),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 501,
      kind: "초록",
      name: "흑녹파스텔",
      decoration: BoxDecoration(
        color: Color(0xFFCEDCC2),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 502,
      kind: "초록",
      name: "광녹파스텔",
      decoration: BoxDecoration(
        color: Color(0xFF87C999),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 503,
      kind: "초록",
      name: "광녹색",
      decoration: BoxDecoration(
        color: Color(0xFF6EDE8C),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 504,
      kind: "초록",
      name: "녹색",
      decoration: BoxDecoration(
        color: Color(0xFF49C86B),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 505,
      kind: "초록",
      name: "백광녹색",
      decoration: BoxDecoration(
        color: Color(0xFFC8FFDE),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 506,
      kind: "초록",
      name: "형광파스텔",
      decoration: BoxDecoration(
        color: Color(0xFF91F8AD),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 508,
      kind: "초록",
      name: "형광녹색",
      decoration: BoxDecoration(
        color: Color(0xFF4BFF00),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 509,
      kind: "초록",
      name: "연잎색",
      decoration: BoxDecoration(
        color: Color(0xFF92CE5F),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 510,
      kind: "초록",
      name: "잎색",
      decoration: BoxDecoration(
        color: Color(0xFF00AD45),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 511,
      kind: "초록",
      name: "잔디색",
      decoration: BoxDecoration(
        color: Color(0xFF4EB168),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 512,
      kind: "초록",
      name: "스카이민트",
      decoration: BoxDecoration(
        color: Color(0xFF0ABFB3),
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 513,
      kind: "초록",
      name: "민트색",
      decoration: BoxDecoration(
        color: Color(0xFF00A78E),
      ),
      isAvailable: true,
    ),
  ],
  "파랑": [
    BackgroundColor(
      id: 3,
      kind: "파랑",
      name: "개파람",
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      isAvailable: true,
    ),
    BackgroundColor(
      id: 4,
      kind: "파랑",
      name: "좀파람",
      color: Colors.red,
      decoration: BoxDecoration(
        color: Colors.blue[300],
      ),
      isAvailable: true,
    ),
  ],
  "보라": [],
  "갈색": [],
  "검정": [],
  "하양": [],
  "흑우": [
    BackgroundColor(
      id: 9999,
      kind: "흑우",
      name: "스페셜",
      color: Colors.red,
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: [
            Colors.blue,
            Colors.green,
            Colors.yellow,
            Colors.red,
            Colors.blue
          ],
          stops: [0.0, 0.25, 0.5, 0.75, 1],
        ),
      ),
      isAvailable: true,
    )
  ]
};
