import 'package:flutter/material.dart';
import '../color.dart';
import '../font.dart';
import '../asset_path.dart';
import 'package:provider/provider.dart';
import '../../fold_page.dart';
import '../provider/userProvider.dart';
import 'dialog.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  DefaultAppBar({this.onActionButtonPressed, this.title});

  var onActionButtonPressed;
  var title;

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState(onActionButtonPressed, title);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar> with TickerProviderStateMixin {
  String value;
  var onActionButtonPressed;
  var title;

  _DefaultAppBarState(_onActionButtonPressed, _title) {
    onActionButtonPressed = _onActionButtonPressed;
    title = _title;
  }

  int result = 0;

  void calculate(num1, num2) {
    setState(() {
      result = num1 + num2;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserStatus userStatus = Provider.of<UserStatus>(context);
    Widget _buildDefaultAppBarActionButton() {
      Widget temp;
      if (onActionButtonPressed != null) {
        temp = IconButton(
          icon: userStatus.isUserButtonToggled ? Icon(Icons.dehaze) : Icon(Icons.person_outline),
          onPressed: () => onActionButtonPressed(),
        );
      } else {
        temp = Container();
      }
      return temp;
    }

    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      centerTitle: true,
      title: _buildDefaultAppBarTitle(),

      elevation: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(),
      ),
      actions: userStatus.isLogined
          ? <Widget>[
              _buildDefaultAppBarActionButton(),
              SizedBox(
                width: 10,
              )
            ]
          : null,
    );
  }

  Widget _buildDefaultAppBarTitle() {
    Widget temp;
    if (title != null) {
      temp = Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: Font.bold),
      );
    } else {
      temp = Container(width: 135, child: Image.asset("images/nav_logo.png"));
    }
    return temp;
  }
}

class FoldAppBar extends StatefulWidget implements PreferredSizeWidget {

  FoldAppBar({this.onPrevButtonPressed, this.onNextButtonPressed, this.onExitButtonPressed, this.title, this.step});

  var onPrevButtonPressed;
  var onNextButtonPressed;
  var onExitButtonPressed;
  var title;

  var step;

  @override
  _FoldAppBarState createState() => _FoldAppBarState(onPrevButtonPressed, onNextButtonPressed, onExitButtonPressed, title, step);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _FoldAppBarState extends State<FoldAppBar> with TickerProviderStateMixin {
  String value;
  var onPrevButtonPressed;
  var onNextButtonPressed;
  var onExitButtonPressed;
  var title;
  var step;

  _FoldAppBarState(_onPrevButtonPressed, _onNextButtonPressed, _onExitButtonPressed, _title, _step) {
    onPrevButtonPressed = _onPrevButtonPressed;
    onNextButtonPressed = _onNextButtonPressed;
    onExitButtonPressed = _onExitButtonPressed;
    title = _title;
    step = _step;
  }

  @override
  Widget build(BuildContext context) {
    FoldStatus foldStatus = Provider.of<FoldStatus>(context);
    print(step);
//    print( Size.fromHeight(kToolbarHeight));

    Widget _buildFoldAppBarNextButton() {
      return Material(
        color: primaryColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
        child: InkWell(
          splashColor: navColor,
          onTap: () {
            foldStatus.nextStep();
          },
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
          child: Container(
//            width : 70,
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
            child: Row(
              children: <Widget>[
                Text(
                  "다음",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      );
    }

    void _showExitWarningDialog() {
      showCustomDialog(
          context: context,
          title: "진짜 나가요?",
          content: "ㄹㅇ?",
          cancelButtonText: "취소",
          confirmButtonText: "나가용",
          cancelButtonAction: () {
            Navigator.pop(context);
          },
          confirmButtonAction: () {
            Navigator.pop(context);
            Navigator.pop(context);
            onExitButtonPressed();
          });
    }

    Widget _buildFoldAppBarExitButton() {
      return Material(
        color: primaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
        child: InkWell(
          splashColor: navColor,
          onTap: () {
            _showExitWarningDialog();
          },
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
          child: Container(
            width: 80,
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_back),
                Text(
                  "나가기",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildFoldAppBarPrevButton() {
      return Material(
        color: primaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
        child: InkWell(
          splashColor: navColor,
          onTap: () {
            foldStatus.prevStep();
          },
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
          child: Container(
            width: 80,
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_back),
                Text(
                  "이전",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildFoldAppBarTitle() {
      return Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            foldStatus.getStep() != 1 ? _buildFoldAppBarPrevButton() : _buildFoldAppBarExitButton(),
            _buildFoldAppBarNextButton(),
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontFamily: Font.bold),
                ),
                SizedBox(height: 3),
                Text(
                  "(${foldStatus.getBalance().toString()}/${foldStatus.maxStep})",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        )
      ]);
    }

    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      backgroundColor: primaryColor,
      centerTitle: true,
      title: _buildFoldAppBarTitle(),

//      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),

      automaticallyImplyLeading: false,

      flexibleSpace: Container(),
      titleSpacing: 0.0,

//      leading: Row(
//        children: <Widget>[
//          SizedBox(width: 20,),
//          _buildFoldAppBarLeadingButton(),
//        ],
//      ),
    );
  }
}
