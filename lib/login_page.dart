import 'package:flutter/material.dart';
import 'package:flutter_front/common/widgets/dialog.dart';
import 'main_page.dart';
import 'common/provider/userProvider.dart';
import 'common/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'request.dart';
import 'common/color.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './common/ip.dart';

import './common/auth.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = new TextEditingController();


  final TextEditingController _pwController = new TextEditingController();
//  final TextEditingController _nameController = new TextEditingController();
  bool _inAsyncCall; //http 요청중이면 true 아니면 false

  @override
  void initState() {
    super.initState();
    _inAsyncCall = false;
    _idController.text = "";
    _pwController.text = "";
//    _idController.text = "TESTid1357";
//    _pwController.text = "TESTpwd!1357";
  }
//
//  void login() async{
//
//  }


  @override
  Widget build(BuildContext context) {
    UserStatus userStatus = Provider.of<UserStatus>(context);

    return Scaffold(
      appBar: DefaultAppBar(title : "로그인"),
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(),
        opacity: 0.2,
        inAsyncCall: _inAsyncCall,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Form(
            child: Column(
              children: <Widget>[
                Container(
                  height: 45,
                  child: TextField(
                    controller: _idController,

                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    onChanged: (value) {},
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: cardColor,
//                    focusColor: Colors.grey,

                      hintText: "아이디를 입력하시던가요ㅋㅋㅋㅋㅋㅋ",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 45,
                  child: TextField(
//                    obscureText: true,
                    controller: _pwController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    onChanged: (value) {},
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: cardColor,
//                    focusColor: Colors.grey,

                      hintText: "비밀번호 입력 하시던가요ㅋㅋㅋㅋㅋㅋ",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Material(
                  color: Color(0xFFE1E1E1),

                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () async {
                      setState(() {
                        _inAsyncCall = true;
                      });

                      var loginResult = await
                      userStatus.login(_idController.text, _pwController.text);

                      if(loginResult == true){
                        Navigator.pop(context);
//                        goMainPage();
                        showCustomAlert(
                          context : context,
                          title : "로그인 성공!",
                          duration: Duration(seconds: 1),
                        );

                      }else{

                      }


                      setState(() {
                        _inAsyncCall = false;
                      });

                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
//                        border: Border.all(
//                          width : 0.4
//                        ),
                      ),
                      child: Text("로그인ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ"),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Material(
                  color: kakaoColor,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("카카오톡으로 로그인 ㅋㅋㅋㅋ"),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  void goMainPage() {
    Navigator.push(
      context,
      FadeRoute(page: MainPage()),
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

