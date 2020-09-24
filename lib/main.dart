import 'package:flutter/material.dart';
import 'common/provider/otherProvider.dart';
import 'main_page.dart';
import './common/color.dart';
import 'package:provider/provider.dart';
import './common/provider/userProvider.dart';
import 'common/data_class.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserStatus>(create: (_) => UserStatus()),
        ChangeNotifierProvider<OtherStatus>(create: (_) => OtherStatus())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "a고딕12",
          primarySwatch: navColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RecipeCard testRecipeCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(),
    );
  }
}
