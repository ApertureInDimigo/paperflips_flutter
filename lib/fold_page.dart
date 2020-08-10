//import 'dart:html';

import 'package:flutter/material.dart';
import 'common/widgets/appbar.dart';
import 'request.dart';
import 'common/color.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'common/data_class.dart';
import 'main.dart';

import 'package:flutter_tts_improved/flutter_tts_improved.dart';
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

  String _platformVersion = 'Unknown';
  FlutterTtsImproved tts = FlutterTtsImproved();

  _FoldPageState(RecipeCard _recipeCard, List<FoldProcess> _foldProcessList) {
    recipeCard = _recipeCard;
    foldProcessList = _foldProcessList;
  }
  bool counterListening = false;


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    print('VOICES: ${await tts.getVoices}');
    print('LANGUAGES: ${await tts.getLanguages}');
//    tts.setPitch(2.0);
    tts.setProgressHandler((String words, int start, int end, String word) {
      setState(() {
        _platformVersion = word;
      });
      print('PROGRESS: $word => $start - $end');
    });
  }

  void _fetchFoldProcessList() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _currentFoldProcess = foldProcessList[0];
    ttsSpeak(_currentFoldProcess.ttsExplainText);
  }

  void ttsSpeak(text) {
    tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
//    BankAccount bankAccount = Provider.of<BankAccount>(context);



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
            child: Center(child: Builder(builder: (context) {
              FoldStatus foldStatus = Provider.of<FoldStatus>(context);

              if (!counterListening) {
                foldStatus.addListener(() {
                  ttsSpeak(foldStatus.getCurrentProcess().ttsExplainText);
                });
                counterListening = true;
              }

              return Material(
                color: navColor,
                child: InkWell(
                  onTap: () {
                    ttsSpeak(foldStatus.getCurrentProcess().ttsExplainText);
                  },
                  child: Container(
                    width: 350,
                    height: 30,
                    alignment: Alignment.center,
                    child: Text(
                        foldStatus.getCurrentProcess().subtitleExplainText),
                  ),
                ),
              );
            })),
          )),
    );
  }
}
