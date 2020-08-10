import 'package:flutter/material.dart';
import '../color.dart';
import '../font.dart';
import '../asset_path.dart';
import 'package:provider/provider.dart';
import '../../fold_page.dart';


class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  DefaultAppBar({this.onActionButtonPressed, this.title});

  var onActionButtonPressed;
  var title;

  @override
  _DefaultAppBarState createState() =>
      _DefaultAppBarState(onActionButtonPressed, title);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar>
    with TickerProviderStateMixin {
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
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      centerTitle: true,
      title: _buildDefaultAppBarTitle(),

      elevation: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(),
      ),
      actions: <Widget>[
        _buildDefaultAppBarActionButton(),
        SizedBox(
          width: 30,
        )
      ],
    );
  }

  Widget _buildDefaultAppBarActionButton() {
    Widget temp;
    if (onActionButtonPressed != null) {
      temp = IconButton(
        icon: new Icon(Icons.person_outline),
        tooltip: "hello",
        onPressed: () => onActionButtonPressed(),
      );
    } else {
      temp = Container();
    }
    return temp;
  }

  Widget _buildDefaultAppBarTitle() {
    Widget temp;
    if (title != null) {
      temp = Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, fontFamily: Font.bold),
      );
    } else {
      temp = Container(width: 135, child: Image.asset("images/nav_logo.png"));
    }
    return temp;
  }
}

class FoldAppBar extends StatefulWidget implements PreferredSizeWidget {
  FoldAppBar({this.onPrevButtonPressed,this.onNextButtonPressed, this.title, this.step});

  var onPrevButtonPressed;
  var onNextButtonPressed;
  var title;

  var step;

  @override
  _FoldAppBarState createState() =>
      _FoldAppBarState(onPrevButtonPressed,onNextButtonPressed, title, step);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _FoldAppBarState extends State<FoldAppBar> with TickerProviderStateMixin {
  String value;
  var onPrevButtonPressed;
  var onNextButtonPressed;
  var title;
  var step;

  _FoldAppBarState(_onPrevButtonPressed, _onNextButtonPressed, _title, _step) {
    onPrevButtonPressed = _onPrevButtonPressed;
    onNextButtonPressed = _onNextButtonPressed;
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
        color: Colors.amber,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
        child: InkWell(
          splashColor: navColor,
          onTap: () {foldStatus.nextStep();},
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
          child: Container(
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(10))),
            child: Row(
              children: <Widget>[
                Text(
                  "다음",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      );
    }

    void _showExitWarningDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("진짜 나가요?"),
            content: new Text("ㄹㅇ?"),
            actions: <Widget>[
              RaisedButton(
                child: new Text("놉"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
               RaisedButton(
                child: new Text("나가요"),
                onPressed: () {
                  Navigator.pop(context); //알림 창 닫힘
                  Navigator.pop(context); //접기 화면 나가짐
                },
              ),
            ],
          );
        },
      );
    }

    Widget _buildFoldAppBarExitButton() {
      return Material(
        color: Colors.amber,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
        child: InkWell(
          splashColor: navColor,
          onTap: () {_showExitWarningDialog();},
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
          child: Container(
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_back),
                Text(
                  "나가기",
                  style: TextStyle(
                    fontSize: 14,
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
        color: Colors.amber,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
        child: InkWell(
          splashColor: navColor,
          onTap: () {foldStatus.prevStep();},
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
          child: Container(
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_back),
                Text(
                  "이전",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }


    Widget _buildFoldAppBarTitle() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          foldStatus.getStep() != 1 ? _buildFoldAppBarPrevButton() : _buildFoldAppBarExitButton(),
          Column(
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
          _buildFoldAppBarNextButton(),
        ],
      );
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
