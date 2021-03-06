import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/provider/otherProvider.dart';
import 'package:flutter_front/common/widgets/dialog.dart';
import 'package:flutter_front/search_page.dart';
import 'package:flutter_front/collection_page.dart';
import 'package:flutter_front/register_page.dart';
import 'package:flutter_front/myRoom_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import './common/color.dart';
import './common/font.dart';
import './common/asset_path.dart';
import 'common/widgets/appbar.dart';
import 'common/widgets/recipe_card.dart';
import 'common/data_class.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
      targetingInfo: MobileAdTargetingInfo(
        keywords: <String>['flutterio', 'beautiful apps'],
        contentUrl: 'https://flutter.cn',
        testDevices: <
            String>[], // Android emulators are considered test devices
      ),
      listener: (MobileAdEvent event) {
        print("hello");
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
      _isUserButtonToggle; //true ??? ?????? ????????? ?????????/???????????? ?????? ??? ?????? ?????????, false ??? ?????? ????????? MapMenu(?????? 4???)??? ?????????.
  bool _isLogined = false; //????????? ??? ????????? ??? true, ????????? false

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
  }

  int result;

  @override
  Widget build(BuildContext context) {
    UserStatus userStatus = Provider.of<UserStatus>(context);
    OtherStatus otherStatus = Provider.of<OtherStatus>(context);
    _isLogined = userStatus.isLogined;

    return WillPopScope(
      onWillPop: () {
        showCustomDialog(
            context: context,
            title: "????????????????????? ????????????????",
            content: "",
            cancelButtonText: "??????",
            confirmButtonText: "?????????",
            cancelButtonAction: () {
              Navigator.pop(context);
            },
            confirmButtonAction: () async {
              print("SD");
              Navigator.pop(context);
              exit(0);
            });

        return;
      },
      child: ModalProgressHUD(
        inAsyncCall: otherStatus.isLoading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
            appBar: DefaultAppBar(onActionButtonPressed: () {
              setState(() {
                _isUserButtonToggle = !_isUserButtonToggle;
              });
              userStatus
                  .setIsUserButtonToggled(!userStatus.isUserButtonToggled);
              print(userStatus.isUserButtonToggled);
            }),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  _buildUpperMenu(), //?????? ?????? ????????????
                  _buildBottomMenu(), //MVP ?????? ?????? ????????????
                  _buildSearchBar(), //?????? ??? ????????? ??????
                ],
              ),
            )),
      ),
    );
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
              "8??? MVP",
              style: TextStyle(fontSize: 22, fontFamily: Font.extraBold),
            ),
          ),
          SizedBox(height: 10),
          _buildMVPCard(),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "?????? ????????????",
              style: TextStyle(fontSize: 22, fontFamily: Font.extraBold),
            ),
          ),
          SizedBox(height: 10),
          _buildRecommendRecipeList(),
          SizedBox(height: 18),
          Center(
            child: Text("Icons copyright (c) Flaticon."),
          ),
          SizedBox(height: 12),
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
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("???????????? ??????????????? ???????????? ???????????????"),
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
          onTap: () {},
          child: Container(
              height: 90,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15),
                  Flexible(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 0),
                          Text("?????? MVP??? ????????????",
                              style: TextStyle(
                                fontFamily: Font.extraBold,
                                fontSize: 21,
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
                              Text("??? ???????????????",
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
              onTap: () {
                goCollectionPage();
              },
              child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "?????????",
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
                decoration: BoxDecoration(),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "????????????",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
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
                decoration: BoxDecoration(),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "?????????",
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
                decoration: BoxDecoration(),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Flexible(
                      child: Image.asset(IconPath.letter_p),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "????????????",
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
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
                userStatus.userInfo["name"] != null
                    ? userStatus.userInfo["name"]
                    : "",
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
                          text: '100', style: TextStyle(fontFamily: Font.bold)),
                      TextSpan(
                          text: ' ???',
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
                          text: '25', style: TextStyle(fontFamily: Font.bold)),
                      TextSpan(
                          text: ' ?????????',
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
                      title: "???????????? ??????????",
                      content: "?????? ????????? ??? ??? ?????????.",
                      cancelButtonText: "??????",
                      confirmButtonText: "????????????",
                      cancelButtonAction: () {
                        Navigator.pop(context);
                      },
                      confirmButtonAction: () {
                        userStatus.logout();
                        Navigator.pop(context);
                        showCustomAlert(
                            context: context,
                            title: "???????????? ??????!",
                            duration: Duration(seconds: 1));
                      });
                },
                child: Container(
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
    UserStatus userStatus = Provider.of<UserStatus>(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          child: child,
          opacity: animation,
        );
      },
      child: Center(
        child: Container(
          child: userStatus.isUserButtonToggled
              ? _buildMyInfoMenu()
              : _buildMapMenu(),
        ),
        key: ValueKey<bool>(_isUserButtonToggle),
      ),
    );
  }

  Widget _buildGuestUpperMenu() {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            child: child,
            opacity: animation,
          );
        },
        child: Container(
          child: _buildLoginMenu(),
        ));
  }

  Widget _buildUpperMenu() {
    return Builder(builder: (context) {
      UserStatus userStatus = Provider.of<UserStatus>(context);
      return Container(
        decoration: BoxDecoration(
          color: navColor,
        ),
        height: MediaQuery.of(context).size.height * 0.085,
        child: userStatus.isLogined == true
            ? _buildLoginedUpperMenu()
            : _buildGuestUpperMenu(),
      );
    });
  }

  Future<List<RecipeCard>> fetchRecommendRecipeList() async {
    final res =
        await http.get("https://paperflips.com/rec/AllData");

    Map<String, dynamic> data = jsonDecode(res.body);

    var recipeList = data["data"];
    print(recipeList);
    print(recipeList.map((x) => RecipeCard.fromJson(x)).toList());
    return recipeList
        .map<RecipeCard>((x) => RecipeCard.fromJson(x))
        .toList()
        .reversed
        .toList();
  }

  Widget _buildRecommendRecipeList() {
    return FutureBuilder(
        future: getAllTasksFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.error);

          if (snapshot.hasError) {
            return Center(
              child: Text("???????????? ?????? ??? ????????????."),
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
            return Column(
                children: snapshot.data
                    .map<Widget>((x) => buildRecipeCard(x))
                    .toList());
          }
        });
  }

  //?????? ???????????? ??????
  void goSearchPage() {
    Navigator.push(
      context,
      FadeRoute(page: SearchPage()),
    );
  }

  //????????? ???????????? ??????
  void goCollectionPage() {
    Navigator.push(
      context,
      FadeRoute(page: CollectionPage()),
    );
  }

  //????????? ???????????? ??????
  void goMyRoomPage() {
    Navigator.push(
      context,
      FadeRoute(page: MyRoomPage()),
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

//????????? ?????? ????????? ????????????
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
