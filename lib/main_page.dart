import 'dart:io';
import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/dialog.dart';
import 'package:flutter_front/search_page.dart';
import 'package:flutter_front/collection_page.dart';
import 'package:flutter_front/register_page.dart';
import 'package:flutter_front/test_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import './common/color.dart';
import './common/font.dart';
import './common/asset_path.dart';

import 'common/widgets/appbar.dart';
import 'common/widgets/recipe_card.dart';
import 'common/data_class.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'myRoom_page.dart';
import 'request.dart';
import './common/ip.dart';
import './common/data_class.dart';
import 'login_page.dart';


import './common/provider/userProvider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {



  InterstitialAd myInterstitial;

  InterstitialAd buildInterstitialAd() {
    return InterstitialAd(
      adUnitId: "ca-app-pub-2755450101712612/1904039260",
      targetingInfo:  MobileAdTargetingInfo(
        keywords: <String>['flutterio', 'beautiful apps'],
        contentUrl: 'https://flutter.cn',
        birthday: DateTime.now(),
        childDirected: false,
        designedForFamilies: false,
        gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
        testDevices: <String>[], // Android emulators are considered test devices
      ),
//      adUnitId: InterstitialAd.testAdUnitId,
      listener: (MobileAdEvent event) {
        print("ello");
        if (event == MobileAdEvent.failedToLoad) {
          myInterstitial..load();
        } else if (event == MobileAdEvent.closed) {
          myInterstitial = buildInterstitialAd()..load();
        }
        print(event);
      },
    );
  }

  void showInterstitialAd() {
    myInterstitial..show();
  }










  bool
      _isUserButtonToggle; //true 면 상단 메뉴에 로그인/회원가입 또는 내 정보 나타남, false 면 상단 메뉴에 MapMenu(버튼 4개)가 나타남.
  bool _isLogined = false; //로그인 된 상태일 때 true, 아니면 false

  _MainPageState() {
    //p.register("idtest11", "pwdtest", "홍길동");
    //p.createPost();
  }

  var getAllTasksFuture;



  @override
  void dispose() {
    myInterstitial.dispose();

    super.dispose();
  }




  @override
  void initState() {
    super.initState();
    _isUserButtonToggle = false;
    _isLogined = false;
    getIsLogined();

    getAllTasksFuture = fetchRecommendRecipeList();


    myInterstitial = buildInterstitialAd()..load();



  }

  void getIsLogined() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "token");
    print(token);
    setState(() {
//      _isLogined = true;
    });
  }




  int result;

  @override
  Widget build(BuildContext context) {

    UserStatus userStatus = Provider.of<UserStatus>(context);

    _isLogined = userStatus.isLogined;


    return Scaffold(
        appBar: DefaultAppBar(onActionButtonPressed: () {
          setState(() {
            _isUserButtonToggle = !_isUserButtonToggle;
//            print(_isUserButtonToggle);
          });
        }),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              _buildUpperMenu(), //앱바 아래 메뉴까지
              _buildBottomMenu(), //MVP 카드 추천 종이접기
              _buildSearchBar(), //클릭 시 검색바 열림
            ],
          ),
        ));
  }

  Widget _buildBottomMenu() {
    return Flexible(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        children: <Widget>[
          SizedBox(height: 25),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "7월 MVP",
              style: TextStyle(
                  fontSize: 22,
//                  fontWeight: FontWeight.bold,
                  fontFamily: Font.extraBold),
            ),
          ),
          SizedBox(height: 10),
          _buildMVPCard(),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "추천 종이접기",
              style: TextStyle(
                  fontSize: 22,
//                  fontWeight: FontWeight.bold,
                  fontFamily: Font.extraBold),
            ),
          ),
          SizedBox(height: 10),
          _buildRecommendRecipeList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Hero(
      tag: "searchBar",
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, -1), // changes position of shadow
            )
          ],
        ),
        child: Row(
          children: <Widget>[
            Flexible(
                child: Material(
              color: cardColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                onTap: () {
                  goSearchPage();
                },
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
//                          color: cardColor,
//                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("원하시는 종이접기를 검색하여 찾아보세요"),
                  ),
                ]),
              ),
            )),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                      padding: EdgeInsets.all(3), child: Icon(Icons.search)),
                  onTap: () {
                    goSearchPage();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMVPCard() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            )
          ]),
      child: Material(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: () {

            showInterstitialAd();

          },
//          splashColor: Colors.white,
          child: Container(
//            margin: EdgeInsets.only(top: 5),
              height: 90,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: 10, right: 20, top: 20, bottom: 20),
                    child: Image.network(
                        '${IP.address}/img/image/종이배.png' /*recipe.iconPath*/),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "김수한무님의",
                            style:
                                TextStyle(fontFamily: Font.bold, fontSize: 12),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5),
                          Text("종이배",
                              style: TextStyle(
                                fontFamily: Font.extraBold,
                                fontSize: 23,
                              ),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 12, right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("클릭하여 구경해보세요",
                                  style: TextStyle(
                                      fontSize: 13, fontFamily: Font.bold)),
                              Icon(
                                Icons.arrow_forward,
                                size: 13,
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildMapMenu() {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Material(
            color: navColor,
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
//                    border: Border.all(width: 0.1),
                    ),
                child: Column(
                  children: <Widget>[
//                      SizedBox(height: 1),
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "레시피공유",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          )),
      Expanded(
          flex: 1,
          child: Material(
            color: navColor,
            child: InkWell(
              onTap: () {
                goCollectionPage();
              },
              child: Container(
                decoration: BoxDecoration(
//                    border: Border.all(width: 0.1),
                    ),
                child: Column(
                  children: <Widget>[
//                      SizedBox(height: 1),
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "컬렉션",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          )),
      Expanded(
          flex: 1,
          child: Material(
            color: navColor,
            child: InkWell(
              onTap: () {
                goMyRoomPage();
              },
              child: Container(
                decoration: BoxDecoration(
//                    border: Border.all(width: 0.1),
                    ),
                child: Column(
                  children: <Widget>[
//                      SizedBox(height: 1),
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "방꾸미기",
                      style: TextStyle(fontSize: 12, ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          )),
      Expanded(
          flex: 1,
          child: Material(
            color: navColor,
            child: InkWell(
              onTap: () {goTestPage();},
              child: Container(
                decoration: BoxDecoration(
//                    border: Border.all(width: 0.1),
                    ),
                child: Column(
                  children: <Widget>[
//                      SizedBox(height: 1),
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "커뮤니티",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          )),
    ]);
  }

  Widget _buildLoginMenu() {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Material(
            color: navColor,
            child: InkWell(
              onTap: () {
                goLoginPage();
              },
              child: Container(
                decoration: BoxDecoration(
//                    border: Border.all(width: 0.1),
                    ),
                child: Column(
                  children: <Widget>[
//                      SizedBox(height: 1),
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "로그인",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          )),
      Expanded(
          flex: 1,
          child: Material(
            color: navColor,
            child: InkWell(
              onTap: () {
                goRegisterPage();
              },
              child: Container(
                decoration: BoxDecoration(
//                    border: Border.all(width: 0.1),
                    ),
                child: Column(
                  children: <Widget>[
//                      SizedBox(height: 1),
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "회원가입",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          )),
    ]);
  }

  Widget _buildMyInfoMenu() {
    UserStatus userStatus = Provider.of<UserStatus>(context);
    return Container(
//      height: ,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(userStatus.userInfo["id"],
                style: TextStyle(fontFamily: Font.bold, fontSize: 17)),
          ),
          Container(
              height: 21,
              child: Row(children: [
                SizedBox(width: 10),
                Image.asset(IconPath.point),
                SizedBox(width: 1),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: '123', style: TextStyle(fontFamily: Font.bold)),
                      TextSpan(
                          text: ' 점',
                          style:
                              TextStyle(fontFamily: Font.normal, fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(width: 5),
              ])),
          Container(
              height: 21,
              child: Row(children: [
                SizedBox(width: 10),
                Image.asset(IconPath.paint_bucket),
                SizedBox(width: 1),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: '69', style: TextStyle(fontFamily: Font.bold)),
                      TextSpan(
                          text: ' 페인트',
                          style:
                              TextStyle(fontFamily: Font.normal, fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(width: 5),
              ])),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                onTap: () {},
                child: Container(
                  height: 28,
                  padding: EdgeInsets.all(5),
                  child: Image.asset(IconPath.gear),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                onTap: () {

                  showCustomDialog(
                      context: context,
                      title: "로그아웃 할까요?",
                      content: "다시 로그인 할 수 있어요.",
                      cancelButtonText: "취소",
                      confirmButtonText: "로그아웃",
                      cancelButtonAction: () {
                        Navigator.pop(context);
                      },
                      confirmButtonAction: () {
                        userStatus.logout();
                        Navigator.pop(context);
                        showCustomAlert(context:context, title:"로그아웃 성공!", duration: Duration(seconds: 1));
                      });


                },
                child: Container(
//                  height: 28,
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.exit_to_app),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoginedUpperMenu() {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
//        return RotationTransition(child: child, turns: animation,);
          return FadeTransition(
            child: child,
            opacity: animation,
          );
        },
        child: Container(
          child: _isUserButtonToggle ? _buildMyInfoMenu() : _buildMapMenu(),
          key: ValueKey<bool>(_isUserButtonToggle),
        ));
//    return AnimatedCrossFade(
//      duration: const Duration(milliseconds: 400),
//      firstChild: _buildLoginMenu(),
//      secondChild: _buildMapMenu(),
//      crossFadeState: _isUserButtonToggle ? CrossFadeState.showFirst : CrossFadeState.showSecond,
//    );
  }

  Widget _buildGuestUpperMenu() {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
//        return RotationTransition(child: child, turns: animation,);
          return FadeTransition(
            child: child,
            opacity: animation,
          );
        },
        child: Container(
          child: _isUserButtonToggle ? _buildLoginMenu() : _buildMapMenu(),
          key: ValueKey<bool>(_isUserButtonToggle),
        ));
//    return AnimatedCrossFade(
//      duration: const Duration(milliseconds: 400),
//      firstChild: _buildLoginMenu(),
//      secondChild: _buildMapMenu(),
//      crossFadeState: _isUserButtonToggle ? CrossFadeState.showFirst : CrossFadeState.showSecond,
//    );
  }

  Widget _buildUpperMenu() {
    return Builder(

      builder: (context){
//        print(MediaQuery.of(context).size.height * 0.085);
        UserStatus userStatus = Provider.of<UserStatus>(context);
        return Container(
//      padding: EdgeInsets.only(bottom: 8, top: 8),
          decoration: BoxDecoration(
            color: navColor,
          ),
          height: MediaQuery.of(context).size.height * 0.085,
          child: userStatus.isLogined == true ? _buildLoginedUpperMenu() : _buildGuestUpperMenu(),
        );
      }
    );
  }

  Future<List<RecipeCard>> fetchRecommendRecipeList() async {
//      await Future.delayed(Duration(seconds: 2));
    final res =
        await http.get("https://paperflips-server.herokuapp.com/rec/AllData");
    //테스트 하려고 하니 갑자기 서버가 터져버려서 못했어요..

    Map<String, dynamic> data = jsonDecode(res.body);

    var recipeList = data["data"];
    print(recipeList);
//    print(recipe);

//    print(RecipeCard.fromJson(recipe));
//    setState(() {});
    print( recipeList.map((x) => RecipeCard.fromJson(x)).toList());
    return  recipeList.map<RecipeCard>((x) => RecipeCard.fromJson(x)).toList();

    return [
      RecipeCard(
          recipeName: "종이배",
          rarity: "normal",
          summary: "배경을 클릭해 종이이배의 소개를 들어봐요!"),
      RecipeCard(
          recipeName: "코끼리",
          rarity: "legend",
          summary: "배경을 클릭해 코코끼리의 소개를 들어봐요!"),
      RecipeCard(
          recipeName: "종이배",
          rarity: "normal",
          summary: "배경을 클릭해 종이배의 소개를 들어봐요!"),
    ];
  }

  Widget _buildRecommendRecipeList() {


    return FutureBuilder(
        future: getAllTasksFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot)
       {
         print(snapshot.error);

          if (snapshot.hasError) {
            return Center(
              child: Text("아니 에러가 왜 나!!!!!!!!!!!!!!!"),
            );
          } else if (snapshot.hasData == false) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(50),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
//            print(snapshot.data[0].recipeName);
//            print("!");
            return Column(
                children: snapshot.data
                    .map<Widget>((x) => buildRecipeCard(x))
                    .toList());
          }
        });

  }

//  print(test2);

  //검색 페이지로 이동
  void goSearchPage() {
    Navigator.push(
      context,
      FadeRoute(page: SearchPage()),
    );
  }

  //컬렉션 페이지로 이동
  void goCollectionPage() {
    Navigator.push(
      context,
      FadeRoute(page: CollectionPage()),
    );
  }

  //마이룸 페이지로 이동
  void goMyRoomPage() {
    Navigator.push(
      context,
      FadeRoute(page: MyRoomPage()),
    );
  }

  void goTestPage() {
    Navigator.push(
      context,
      FadeRoute(page: TestPage()),
    );
  }



  void goRegisterPage() {
    Navigator.push(
      context,
      FadeRoute(page: RegisterPage()),
    );
  }

  void goLoginPage() {
    Navigator.push(
      context,
      FadeRoute(page: LoginPage()),
    );
  }
}

//페이지 이동 디졸브 트랜지션
class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
