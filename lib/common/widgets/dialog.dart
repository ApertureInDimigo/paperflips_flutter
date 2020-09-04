import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../color.dart';
import '../font.dart';
import '../asset_path.dart';
import 'package:provider/provider.dart';
import '../../fold_page.dart';

void showCustomAlert({
  BuildContext context,
  String title,
  Duration duration,
}) {
//  return;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(duration, () {
        Navigator.pop(context);
      });

      return Center(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
            ),
            width: 200,
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(IconPath.green_success, width: 60),
                SizedBox(height: 15),
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontFamily: Font.bold),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showCustomDialog(
    {BuildContext context,
    String title,
    String content,
    String cancelButtonText,
    String confirmButtonText,
    var cancelButtonAction,
    var confirmButtonAction}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        contentPadding: EdgeInsets.only(top: 0.0),
        titlePadding: EdgeInsets.all(0),
        buttonPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        actionsOverflowButtonSpacing: 0,
//        buttonPadding : EdgeInsets.all(0),
        content: Container(
//          height : 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 25,
                      child: Row(
                        children: <Widget>[
                          Image.asset(IconPath.letter_p),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            title,
                            style: TextStyle(fontSize: 20, fontFamily: Font.extraBold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      content,
                      style: TextStyle(fontSize: 15, fontFamily: Font.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Material(
                        color: cardColor,
                        child: InkWell(
                          onTap: cancelButtonAction,
                          child: Container(
                            height: 35,
                            child: Center(
                              child: Text(cancelButtonText),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: primaryColor,
                        child: InkWell(
                          onTap: confirmButtonAction,
                          child: Container(
                            height: 35,
                            child: Center(
                              child: Text(confirmButtonText),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        actions: <Widget>[],
      );
    },
  );
}
