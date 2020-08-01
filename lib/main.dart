import 'package:flutter/material.dart';
import 'MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HelloPage('Hello World'));
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
            Text('$_counter', style: TextStyle(fontSize: 30)),
            RaisedButton(
              child: Text('화면 이동'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MainPage()));
              },
            )
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
