//import 'dart:html';
import 'package:flutter/material.dart';
import 'common/font.dart';
import 'common/ip.dart';
import 'common/widgets/appbar.dart';
import 'request.dart';
import 'common/color.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'common/data_class.dart';
import 'main.dart';

import 'package:flutter_tts_improved/flutter_tts_improved.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
//import 'package:flutter_tts/flutter_tts.dart';

class FoldStatus with ChangeNotifier {
  int _step = 1;

  int maxStep;
  List<FoldProcess> foldProcessList;

  FoldStatus(int _maxStep, List<FoldProcess> _foldProcessList) {
    maxStep = _maxStep;
    foldProcessList = _foldProcessList;
  }

  FoldProcess getCurrentProcess() {
    return foldProcessList[_step - 1];
  }

  int getStep() {
    return _step;
  }

  int getBalance() {
    print(maxStep);
    return _step;
  }

  void nextStep() {

    if (_step + 1 <= maxStep) {
      _step += 1;
    }

    notifyListeners(); //must be inserted
  }

  void prevStep() {
    if (_step - 1 >= 1) {
      _step -= 1;
    }
//    _step -= 1;
    notifyListeners(); //must be inserted
  }
}

class FoldPage extends StatefulWidget {
  final RecipeCard recipeCard;
  List<FoldProcess> foldProcessList;

  FoldPage(this.recipeCard, this.foldProcessList);

  @override
  _FoldPageState createState() => _FoldPageState(recipeCard, foldProcessList);
}

class _FoldPageState extends State<FoldPage> {
  RecipeCard recipeCard;

  List<FoldProcess> foldProcessList;

  FoldProcess _currentFoldProcess;

  UnityWidgetController _unityWidgetController;

  String _platformVersion = 'Unknown';
  FlutterTtsImproved tts = FlutterTtsImproved();

  _FoldPageState(RecipeCard _recipeCard, List<FoldProcess> _foldProcessList) {
    recipeCard = _recipeCard;
    foldProcessList = _foldProcessList;


  }

  bool counterListening = false;

  bool _isSpeakingTTS ;



  Map<String, dynamic> _readingWord;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    await tts.setPitch(0.1);
    print('VOICES: ${await tts.getVoices}');
    print('LANGUAGES: ${await tts.getLanguages}');
//    tts.setPitch(2.0);
    tts.setStartHandler(() {

      setState(() {
        _isSpeakingTTS = true;
      });
    });
    
    tts.setCompletionHandler(() {
//      print("h1!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      setState(() {
        _isSpeakingTTS = false;
      });
    });


    
    
    tts.setProgressHandler((String words, int start, int end, String word) {
      setState(() {
        _platformVersion = word;
      });
      setState(() {
        _readingWord = {"start" : start, "end" : end};
      });

      print('PROGRESS: $word => $start - $end');
    });
  }
//  initPlatformState();

  void _fetchFoldProcessList() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _currentFoldProcess = foldProcessList[0];
    ttsSpeak(_currentFoldProcess.ttsExplainText);
    _readingWord = {"start" : 0, "end" : 0};
    _isSpeakingTTS = false;
  }

  void ttsSpeak(text) {
    tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
//    BankAccount bankAccount = Provider.of<BankAccount>(context);
//    print(_readingWord);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FoldStatus>(
            builder: (_) => FoldStatus(8, foldProcessList)),
      ],
      child: Scaffold(
          appBar: FoldAppBar(
            title: recipeCard.recipeName,
            onPrevButtonPressed: () {
//              bankAccount.decrement(1);
//              setState(() {
//                _currentStep = _currentStep - 1;
//              });
//              print(_currentStep);
            },
            onNextButtonPressed: () {
//              bankAccount.increment(1);
//              setState(() {
//                _currentStep = _currentStep + 1;
//              });
//              print(_currentStep);
            },
          ),
          body: Container(
            child: Stack(children: [
              UnityWidget(
                onUnityViewCreated: onUnityCreated
              ),
              Container(
//                  color: Colors.blue,
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Builder(builder: (context) {
                    FoldStatus foldStatus = Provider.of<FoldStatus>(context);

                    if (!counterListening) {

                      foldStatus.addListener(() {
                        ttsSpeak(foldStatus.getCurrentProcess().ttsExplainText);
                      });
                      counterListening = true;
                    }

                    Widget _buildSubtitleText(String text){
//                      print( _readingWord["start"]);
                      print(_isSpeakingTTS);
                      if(_isSpeakingTTS == false || _readingWord["end"] > text.length){
                        return Text(text, style : TextStyle(
                            color: Colors.black, fontSize: 15, fontFamily: Font.normal));
                      }


                      List<TextSpan> temp = [
//                        TextSpan(text : text.substring(0, _readingWord["start"])),
                        TextSpan(text : text.substring(0, _readingWord["end"]), style: TextStyle(color: Colors.red)),
                        TextSpan(text : text.substring(_readingWord["end"], text.length))
                      ];
                      print(temp);
//                      return Text(text);


                      return RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black, fontSize: 15, fontFamily: Font.normal),
                            children: temp
                        )
                      );

                      return Text(text);
                    }


                    return Container(
                      child: Column(
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Material(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: navColor,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                onTap: () {
                                  ttsSpeak(foldStatus
                                      .getCurrentProcess()
                                      .ttsExplainText);
                                },
                                child: Container(
//                      margin: EdgeInsets.symmetric(horizontal: 50),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 36,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: _buildSubtitleText(foldStatus
                                      .getCurrentProcess()
                                      .ttsExplainText),
                                ),
                              ),
                            ),
                            SizedBox(height : 25),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)
                                ),
                                color : navColor,
                              ),
//                              width :  MediaQuery.of(context).size.width * 0.3,
//                              height : 240,
                              padding: EdgeInsets.all(25),
                              child: Column(
                                children: <Widget>[
                                  Image.asset('images/fold_icon.png', width: 100, height: 100,),
                                ],
                              ),
                            )
                          ]),
                    );
                  })),

            ]),
          )),
    );
  }

  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}
