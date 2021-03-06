import 'package:flutter/material.dart';
import 'common/font.dart';
import 'common/widgets/appbar.dart';
import 'common/widgets/dialog.dart';
import 'common/color.dart';
import 'package:provider/provider.dart';
import 'common/data_class.dart';
import 'package:flutter_tts_improved/flutter_tts_improved.dart';

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

  bool nextStep() {
    if (_step + 1 <= maxStep) {
      _step += 1;
      notifyListeners(); //must be inserted
      return true;
    } else {
      return false;
    }
  }

  void prevStep() {
    if (_step - 1 >= 1) {
      _step -= 1;
    }
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

  bool _isSpeakingTTS;

  @override
  void dispose() {
    print("Called dispose");
    super.dispose();
  }

  Map<String, dynamic> _readingWord;

  Future<void> initPlatformState() async {
    if (!mounted) return;
    await tts.setPitch(0.1);
    print('VOICES: ${await tts.getVoices}');
    print('LANGUAGES: ${await tts.getLanguages}');

    tts.setLanguage("ko-KR");
    tts.setStartHandler(() {
      setState(() {
        _isSpeakingTTS = true;
      });
    });

    tts.setCompletionHandler(() {
      setState(() {
        _isSpeakingTTS = false;
      });
    });

    tts.setProgressHandler((String words, int start, int end, String word) {
      setState(() {
        _platformVersion = word;
      });
      setState(() {
        _readingWord = {"start": start, "end": end};
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
    _readingWord = {"start": 0, "end": 0};
    _isSpeakingTTS = false;
  }

  void ttsSpeak(text) {
    tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          tts.stop();
          showCustomDialog(
              context: context,
              title: "?????? ????????????????",
              content: "",
              cancelButtonText: "??????",
              confirmButtonText: "?????????",
              cancelButtonAction: () {
                Navigator.pop(context);
              },
              confirmButtonAction: () async {
                print("SD");

                Navigator.pop(context);
                Navigator.pop(context);
              });

          return true;
        },
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<FoldStatus>(
                builder: (_) =>
                    FoldStatus(foldProcessList.length, foldProcessList)),
          ],
          child: Scaffold(
              appBar: FoldAppBar(
                title: recipeCard.recipeName,
                recipe: recipeCard,
                onPrevButtonPressed: () {
                  tts.stop();
                },
                onExitButtonPressed: () {
                  tts.stop();
                },
                onNextButtonPressed: () {},
              ),
              body: Container(
                color: Colors.white,
                child: Stack(children: [
                  Builder(
                    builder: (context) {
                      FoldStatus foldStatus = Provider.of<FoldStatus>(context);
                      return Container(
                          child: Center(
                        child: FractionallySizedBox(
                          widthFactor: 8 / 10,
                          child: Image.network(
                            foldStatus.getCurrentProcess().imgPath,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ));
                    },
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Builder(builder: (context) {
                        FoldStatus foldStatus =
                            Provider.of<FoldStatus>(context);

                        if (!counterListening) {
                          foldStatus.addListener(() {
                            ttsSpeak(
                                foldStatus.getCurrentProcess().ttsExplainText);
                          });
                          counterListening = true;
                        }

                        Widget _buildSubtitleText(String text) {
                          print(_isSpeakingTTS);
                          if (_isSpeakingTTS == false ||
                              _readingWord["end"] > text.length) {
                            return Text(text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: Font.normal));
                          }

                          List<TextSpan> temp = [
                            TextSpan(
                                text: text.substring(0, _readingWord["end"]),
                                style: TextStyle(color: Colors.red)),
                            TextSpan(
                                text: text.substring(
                                    _readingWord["end"], text.length))
                          ];
                          print(temp);
//                      return Text(text);

                          return RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: Font.normal),
                                  children: temp));
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
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 36,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                      child: _buildSubtitleText(foldStatus
                                          .getCurrentProcess()
                                          .ttsExplainText),
                                    ),
                                  ),
                                ),
                              ]),
                        );
                      })),
                ]),
              )),
        ));
  }
}
