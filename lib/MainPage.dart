import 'package:flutter/material.dart';
import 'size.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    size s = new size(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.yellowAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            backgroundColor: Color(0xFFFFD814),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  width: s.width * 0.76,
                ),
              ],
            ))));
  }
}

class BottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text('한국디지털미디어고등학교 Paperflips팀'),
        Text('조민준ㆍ유태연ㆍ조민수ㆍ박용한ㆍ정재엽')
      ],
    ));
  }
}