import 'package:flutter/material.dart';
import 'package:flutter_front/common/widgets/dialog.dart';
import 'main_page.dart';
import 'common/provider/userProvider.dart';
import 'common/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'common/color.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = new TextEditingController();

  final TextEditingController _pwController = new TextEditingController();

  var _id = "";
  var _pw = "";
  bool _inAsyncCall; //http 요청중이면 true 아니면 false

  @override
  void initState() {
    super.initState();
    _inAsyncCall = false;
    _idController.text = "";
    _pwController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    UserStatus userStatus = Provider.of<UserStatus>(context);

    return Scaffold(
      appBar: DefaultAppBar(title: "로그인"),
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
                    onChanged: (value) {
                      setState(() {
                        _id = value.trim();
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: cardColor,
                      hintText: "아이디를 입력해주세요",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 45,
                  child: TextField(
                    obscureText: true,
                    controller: _pwController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    onChanged: (value) {
                      setState(() {
                        _pw = value.trim();
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: cardColor,
                      hintText: "비밀번호를 입력해주세요",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Material(
                  color:
                      _id != "" && _pw != "" ? primaryColor : Color(0xFFE1E1E1),
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: _id != "" && _pw != ""
                        ? () async {
                            setState(() {
                              _inAsyncCall = true;
                            });

                            var loginResult = await userStatus.login(
                                _idController.text, _pwController.text);

                            if (loginResult == true) {
                              Navigator.pop(context);
                              showCustomAlert(
                                context: context,
                                title: "로그인 성공!",
                                duration: Duration(seconds: 1),
                              );
                            } else {
                              showCustomAlert(
                                  context: context,
                                  title: "아이디나 비밀번호가 옳지 않습니다.",
                                  duration: Duration(seconds: 1),
                                  isSuccess: false,
                                  width: 400);
                            }

                            setState(() {
                              _inAsyncCall = false;
                            });
                          }
                        : null,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("로그인"),
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
