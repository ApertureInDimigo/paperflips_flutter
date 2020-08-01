import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'size.dart';

class MainPage extends StatelessWidget {
  //
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     size s = new size(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.yellowAccent,

          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            backgroundColor: Color(0xFFFFD814),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/logo.png',
                    width: s.width * 0.76,
                                        ),
              ],
            )
          )
        )
      );
  }
}


class bottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Text('한국디지털미디어고등학교 Paperflips팀'),
        Text('조민준ㆍ유태연ㆍ조민수ㆍ박용한ㆍ정재엽')
      ],)
    );
  }
}

class HelloPage extends StatefulWidget {
  final String title;

  HelloPage(this.title);

  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  String _message = "Hello, world";
  int _counter = 0;
  String _message_2 = " ";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: _changeMessage),
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_message, style: TextStyle(fontSize: 30)),
            Text('$_counter', style: TextStyle(fontSize: 30))
          ],
        )));
  }

  void _changeMessage() {
    setState(() {
      _message = "바꾸고 싶은 글자";
      _counter++;
    });
  }
}
