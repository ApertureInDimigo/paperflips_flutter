import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'common/ad_manager.dart';
import 'common/provider/otherProvider.dart';
import 'main_page.dart';
import 'introduce.dart';
import './common/color.dart';
import 'collection_page.dart';
import 'register_page.dart';
import 'package:provider/provider.dart';

import './common/provider/userProvider.dart';
//import 'package:permission_handler/permission_handler.dart';

import 'myRoom_page.dart';
import 'foldComplete_page.dart';
import 'common/data_class.dart';

import 'package:firebase_admob/firebase_admob.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void permission() async {
  //Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.camera]);
  //print('per1 : $permissions');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    permission();
//    UserStatus userStatus = Provider.of<UserStatus>(context);

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //body: FoldCompletePage(testRecipeCard),
      body: MainPage(),
    );
  }
}
