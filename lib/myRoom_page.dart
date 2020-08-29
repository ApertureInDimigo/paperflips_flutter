//import 'dart:html';

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/appbar.dart';
import 'package:flutter_front/common/widgets/recipe_card.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipedetector/swipedetector.dart';
import 'dart:convert';
import 'common/color.dart';
import 'common/data_class.dart';
import 'dart:core';

import 'common/font.dart';
import 'common/ip.dart';
import 'fold_page.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:vibration/vibration.dart';

GlobalKey _keyStickerBackground = GlobalKey();
PanelController _pc = new PanelController();

class PlaceStatus with ChangeNotifier {
  List<PlacedSticker> placedStickerList = [];
  List<Sticker> stickerList = [];

  double defualtStickerWidth = 50;

  PlaceStatus() {
    setStickerList();
  }

  void setStickerList() {
    stickerList = [
      Sticker(id: 1, name: "종이배", path: '${IP.address}/img/image/종이배.png', limit: 9, count: 0),
      Sticker(id: 2, name: "코끼리", path: '${IP.address}/img/image/코끼리.png', limit: 5, count: 0),
      Sticker(id: 3, name: "황구리", path: '${IP.address}/img/image/황금개구리.png', limit: 1, count: 0),
    ];
    notifyListeners();
  }

  PlacedSticker selectedSticker;

  void saveCurrentStatus() {
    void printWrapped(String text) {
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern.allMatches(text).forEach((match) => print(match.group(0)));
    }

    final RenderBox renderBox = _keyStickerBackground.currentContext.findRenderObject();
    double renderBoxWidth = renderBox.size.width;
    double renderBoxHeight = renderBox.size.height;

    var data = placedStickerList.where((x) => x.visible == true).toList().map((x) => x.toJson()).toList();
    log(jsonEncode({"renderBoxWidth": renderBoxWidth, "renderBoxHeight": renderBoxHeight, "data": data}));
  }

  void loadStatus() {
    final RenderBox renderBox = _keyStickerBackground.currentContext.findRenderObject();
    double renderBoxWidth = renderBox.size.width;
    double renderBoxHeight = renderBox.size.height;
    final positionStickerBackground = renderBox.localToGlobal(Offset.zero);
//    var loaded = jsonDecode(
//        '{"renderBoxWidth":358.85714285714283,"renderBoxHeight":717.7142857142857,"data":[{"id":0,"initPos":{"dx":87.62323288690476,"dy":245.82061434659056},"initScale":1.0,"sticker":{"id":2,"name":"코끼리","path":"https://paperflips-server.herokuapp.com/img/image/코끼리.png","limit":5}},{"id":1,"initPos":{"dx":81.32886904761901,"dy":159.5325947641472},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":2,"initPos":{"dx":165.03841145833331,"dy":97.2551115052189},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":3,"initPos":{"dx":243.04287574404785,"dy":241.18461681547592},"initScale":1.0,"sticker":{"id":3,"name":"황구리","path":"https://paperflips-server.herokuapp.com/img/image/황금개구리.png","limit":1}}]}');
    var loaded = jsonDecode('{"renderBoxWidth":358.85714285714283,"renderBoxHeight":717.7142857142857,"data":[{"id":0,"initPos":{"dx":154.18154761904762,"dy":159.79871144480478},"initScale":1.0,"sticker":{"id":2,"name":"코끼리","path":"https://paperflips-server.herokuapp.com/img/image/코끼리.png","limit":5}},{"id":1,"initPos":{"dx":156.19047619047618,"dy":214.66896814123345},"initScale":1.0,"sticker":{"id":2,"name":"코끼리","path":"https://paperflips-server.herokuapp.com/img/image/코끼리.png","limit":5}},{"id":2,"initPos":{"dx":158.47563244047618,"dy":267.2422103287334},"initScale":1.0,"sticker":{"id":2,"name":"코끼리","path":"https://paperflips-server.herokuapp.com/img/image/코끼리.png","limit":5}},{"id":3,"initPos":{"dx":154.4789806547619,"dy":325.8209597195037},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":4,"initPos":{"dx":105.33556547619045,"dy":325.79515056771817},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":5,"initPos":{"dx":43.90001860119045,"dy":330.1052789159327},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":6,"initPos":{"dx":210.18908110119045,"dy":327.8082644070038},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":7,"initPos":{"dx":266.1754092261907,"dy":326.9307532462897},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":8,"initPos":{"dx":128.6974621414766,"dy":84.27572665040529},"initScale":1.9627674369599777,"sticker":{"id":3,"name":"황구리","path":"https://paperflips-server.herokuapp.com/img/image/황금개구리.png","limit":1}}]}');

        double widthRatio = renderBoxWidth / loaded["renderBoxWidth"];
    double heightRatio = renderBoxHeight / loaded["renderBoxHeight"];
    print(widthRatio);
    print(heightRatio);

    List<PlacedSticker> data = loaded["data"].map<PlacedSticker>((x) => PlacedSticker.fromJson(x)).toList();

    for (int i = 0; i < stickerList.length; i++) {
//      print("heell");
      try{
        stickerList[i].limit = data.where((x) => x.sticker.id == stickerList[i].id).toList()[0].sticker.limit;
      }catch(e){

      }

      stickerList[i].count = 0;
//      print(stickerList[i].limit);
    }
    for (int i = 0; i < data.length; i++) {
//      print("heell");
      data[i].sticker = stickerList.where((x) => x.id == data[i].sticker.id).toList()[0];
      data[i].sticker.count += 1;

      data[i].position = Offset(data[i].initPos.dx * widthRatio, data[i].initPos.dy * heightRatio );
    }

    for (int i = 0; i < data.length; i++) {
//      data.where((x) => x.sticker.id == data[i].sticker.id).toList().every((x) {
//        x.sticker.count += 1;
//        return true;
//      });
    print(data[i].position);
    }
    for (int i = 0; i < stickerList.length; i++) {
//      print("heell");
//      print(stickerList[i].count);

//      print(data[1].initPos);

    }

    defualtStickerWidth = 50 * widthRatio;
    print(defualtStickerWidth);
    placedStickerList = data;
//    stickerList = loadedStickerList;

//    print(loadedStickerList.toList());
//    print()

    notifyListeners();
  }

  void clear() {
    for (int i = 0; i < placedStickerList.length; i++) {
      placedStickerList[i].sticker.count -= 1;
    }
    placedStickerList = [];
    notifyListeners();
  }

  void moveSticker(int id, Offset offset) {
    PlacedSticker temp;
    placedStickerList.where((x) => x.id == id).toList().every((x) {
      x.position = offset;
//      temp =  jsonDecode(jsonEncode(x));
//      print(temp.sticker);
//      x.visible = false;
//      temp = PlacedSticker(x.id, offset ,x.initScale, x.sticker);
//      placedStickerList.remove(x);
      return true;
    });

//    placedStickerList = [];
//
////    notifyListeners();
//    placedStickerList = [temp];
//    print(temp.sticker.path);
//    print(temp.position);
//    placedStickerList.remove(temp);
//    print(temp.sticker.name);
//    temp.visible = true;
//    placedStickerList.insert(0, temp);
    notifyListeners();
  }

  void updateStickerScale(double scaleFactor) {
    double currentScale = selectedSticker.scale;
    double afterScale = currentScale * (scaleFactor >= 1 ? 1.02 : 0.98);
    afterScale = defualtStickerWidth * afterScale <= 150
        ? (defualtStickerWidth * afterScale >= 20 ? afterScale : 20 / defualtStickerWidth)
        : 150 / defualtStickerWidth;

    selectedSticker.scale = afterScale;
    selectedSticker.position = Offset(selectedSticker.position.dx - (defualtStickerWidth * (afterScale - currentScale) / 2),
        selectedSticker.position.dy - (defualtStickerWidth * (afterScale - currentScale) / 2));
    notifyListeners();

//    setState(() {
////      _position = Offset(
////          _position.dx - (50 * (afterScale - currentScale) / 2),
////          _position.dy - (50 * (afterScale - currentScale) / 2));
//      _scale = afterScale;
//    });
  }

  void addSticker(PlacedSticker placedSticker) {
//    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
    placedStickerList.add(placedSticker);
    notifyListeners();
  }

  void selectSticker(int id) {
    bool isSelected;
    placedStickerList.where((x) => x.id == id).toList().every((x) {
      isSelected = x.selected;
      return true;
    });
    placedStickerList.every((x) {
      print(x);
      x.selected = false;
      return true;
    });
    placedStickerList.where((x) => x.id == id).toList().every((x) {
      x.selected = !isSelected;
      if (x.selected == true) {
        selectedSticker = x;
      } else {
        selectedSticker = null;
      }
      return true;
    });
    notifyListeners();
  }

  void retrieveSticker(int id) {
    print(id);
    for (int i = 0; i < placedStickerList.length; i++) {
      if (placedStickerList[i].id == id) {
        placedStickerList[i].sticker.count -= 1;
        placedStickerList[i].visible = false;
        print(placedStickerList[i].id);
//        placedStickerList.removeAt(i);
        notifyListeners();
        break;
      }
    }
  }
}

class Sticker {
  int id;
  String name;
  String path;
  int limit;
  int count;

  Sticker({this.id, this.name, this.path, this.limit, this.count});
}

class PlacedSticker extends StatefulWidget {
  int id;

  double initScale;

  Offset initPos;
  Sticker sticker;

  double scale = 1.0;
  Offset position = Offset(0, 0);
  bool selected = false;

  bool visible = true;

  PlacedSticker.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    initPos = Offset(json["initPos"]["dx"], json["initPos"]["dy"]);
    position = initPos;

    initScale = json["initScale"];
    scale = initScale;

    sticker = Sticker(
        id: json["sticker"]["id"],
        name: json["sticker"]["name"],
        path: json["sticker"]["path"],
        limit: json["sticker"]["limit"],
        count: 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['initPos'] = {"dx": this.position.dx, "dy": this.position.dy};

    data['initScale'] = this.scale;
    print(this.scale);
//    data['sticker'] = {"id": this.sticker.id};

    data['sticker'] = {
      "id": this.sticker.id,
      "name": this.sticker.name,
      "path": this.sticker.path,
      "limit": this.sticker.limit
    };
    print(data);
    return data;
  }

//  PlacedSticker(this.id, this.initPos, this.initScale, this.sticker);

  PlacedSticker(int id, Offset initPos, double initScale, Sticker sticker) {
    this.id = id;
    this.initPos = initPos;
    this.initScale = initScale;
    this.sticker = sticker;
    this.position = initPos;
  }

  @override
  _PlacedStickerState createState() => _PlacedStickerState(id, initPos, initScale, sticker);
}

class _PlacedStickerState extends State<PlacedSticker> {
  int id;
  Offset initPos;
  double initScale;

  Sticker sticker;

  double _scaleFactor = 1.0;

  bool _isPanelOpen;

  _PlacedStickerState(int _id, Offset _initPos, double _initScale, Sticker _sticker) {
    id = _id;
    initPos = _initPos;
    initScale = _initScale;
    sticker = _sticker;
  }

  @override
  void initState() {
    super.initState();
    _isPanelOpen = _pc.isPanelOpen;
  }

  @override
  Widget build(BuildContext context) {
//    print(id);
    PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
    return Positioned(
      key: GlobalKey(),
      left: widget.position.dx,
      top: widget.position.dy,
      child: Visibility(
        visible: widget.visible,
        child: GestureDetector(
          onScaleStart: (details) {},
          onTap: () {
            placeStatus.selectSticker(id);
//            select
//            setState(() {
//              double currentScale = _scale;
//              double afterScale =
//                  currentScale <= 3 ? currentScale + 0.2 : currentScale;
//              setState(() {
//                _position = Offset(
//                    _position.dx - (50 * (afterScale - currentScale) / 2),
//                    _position.dy - (50 * (afterScale - currentScale) / 2));
//                _scale = afterScale;
//              });
//            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: widget.selected ? Colors.white.withOpacity(0.8) : null,
            ),

//        width: 0,
//        height: 50,
            child: Draggable(
                onDragStarted: () {
                  if (_pc.isPanelOpen == true) {
                    _pc.close();
                    _isPanelOpen = true;
                  } else {
                    _isPanelOpen = false;
                  }

//                  Vibration.vibrate(duration: 80);
                },
                feedbackOffset: Offset.fromDirection(10),
                dragAnchor: DragAnchor.child,
                child: Image.network(
                  sticker.path,
                  width: placeStatus.defualtStickerWidth * widget.scale,
                ),
                feedback: Image.network(
                  sticker.path,
                  width: placeStatus.defualtStickerWidth * widget.scale,
                ),
                childWhenDragging: Container(),
                onDragEnd: (data) {
                  if (_isPanelOpen == true) {
                    _pc.open();
                  }

                  if (data.wasAccepted == true) {
                    final RenderBox renderBox = _keyStickerBackground.currentContext.findRenderObject();
                    final positionStickerBackground = renderBox.localToGlobal(Offset.zero);

//                    setState(() {
//                      _position = Offset(
//                          data.offset.dx - positionStickerBackground.dx,
//                          data.offset.dy - positionStickerBackground.dy);
//                    });
                    placeStatus.moveSticker(
                        id,
                        Offset(
                            data.offset.dx - positionStickerBackground.dx, data.offset.dy - positionStickerBackground.dy));
//                    widget.position = Offset(
//                        data.offset.dx - positionStickerBackground.dx,
//                        data.offset.dy - positionStickerBackground.dy);
                    print(widget.position);
                  } else {
                    PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);

                    placeStatus.retrieveSticker(id);
                  }
                },
                data: sticker),
          ),
        ),
      ),
    );
  }
}

class MyRoomPage extends StatefulWidget {
  @override
  _MyRoomPageState createState() => _MyRoomPageState();
}

class _MyRoomPageState extends State<MyRoomPage> {
  List<Sticker> _stickerList;
  List<PlacedSticker> _placedStickerList;

  final double _initFabHeight = 27.0;
  double _fabHeight;
  double _panelHeightOpen = 300;
  double _panelHeightClosed = 25.0;

  int count = 0;

  bool _inAsyncCall = false;

  @override
  void initState() {
    super.initState();
    _inAsyncCall = false;
    _fabHeight = 300;
    _placedStickerList = [
//      PlacedSticker(
//        Offset(50, 50),
//        Sticker(
//            id: 1,
//            name: "종이배",
//            path: '${IP.address}/img/image/종이배.png',
//            limit: 9),
//      ),
//      PlacedSticker(
//        Offset(50, 150),
//        Sticker(
//            id: 1,
//            name: "종이배",
//            path: '${IP.address}/img/image/종이배.png',
//            limit: 9),
//      )
    ];

//    _getMySongList();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildUtilButtons() {
      return Builder(
        builder: (context) {
          PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
          return Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Material(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onTap: () {
                        placeStatus.saveCurrentStatus();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Icon(Icons.check),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Material(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onTap: () {
//                        placeStatus.loadStatus();
                        placeStatus.clear();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Icon(Icons.layers_clear),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Material(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onTap: () {
                        placeStatus.loadStatus();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Icon(Icons.cloud_download),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    Widget _buildUnderSticker(Sticker sticker) {
      return Builder(
        builder: (context) {
          PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
          return Material(
            color: navColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: FractionallySizedBox(
                        widthFactor: 2 / 3,
                        child: Builder(
                          builder: (_) {
                            if (sticker.limit - sticker.count <= 0) {
                              return Image.network(
                                sticker.path,
                                color: Colors.grey,
                              );
                            }

                            return LongPressDraggable(
                                onDragStarted: () {
                                  _pc.close();
                                  Vibration.vibrate(duration: 80);
                                },
                                feedbackOffset: Offset.fromDirection(10),
                                dragAnchor: DragAnchor.child,
                                child: Image.network(sticker.path),
                                feedback: Image.network(
                                  sticker.path,
                                  width: placeStatus.defualtStickerWidth,
                                ),
                                onDragEnd: (data) {
                                  _pc.open();
                                  if (data.wasAccepted == true) {
                                    final RenderBox renderBox = _keyStickerBackground.currentContext.findRenderObject();
                                    final positionStickerBackground = renderBox.localToGlobal(Offset.zero);

                                    placeStatus.addSticker(PlacedSticker(
                                        count++,
                                        Offset(data.offset.dx - positionStickerBackground.dx,
                                            data.offset.dy - positionStickerBackground.dy),
                                        1.0,
                                        sticker));

                                    setState(() {
                                      sticker.count += 1;
                                    });
                                  }
                                },
                                data: sticker);
                          },
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Builder(builder: (context) {
                        PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
                        return Text((sticker.limit - sticker.count).toString());
                      }),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    Widget _buildUnderStickerBox() {
      return Builder(
        builder: (context) {
          PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
          return Column(children: [
            Container(
//                      color: Colors.green,
              margin: EdgeInsets.all(8),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 5,
                    decoration:
                        BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFFFFFFF),
              height: 270,
              child: Column(children: [
                Flexible(
                  child: Container(
//            height : 250,
                    padding: EdgeInsets.only(left: 10, top: 2, right: 10, bottom: 10),

                    child: GridView.count(
//        physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      //스크롤 방향 조절
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 5,

                      children: placeStatus.stickerList.map((x) => _buildUnderSticker(x)).toList(),
                    ),
                  ),
                ),
              ]),
            ),
          ]);
        },
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlaceStatus>(create: (_) => PlaceStatus()),
      ],
      child: Scaffold(
          appBar: DefaultAppBar(title: "방 꾸미기"),
          // 2-1. 상세 화면 (전체 화면 세팅1)
          body: SwipeDetector(
            onSwipeDown: () {
              _pc.close();
            },
            onSwipeUp: () {
              _pc.open();
            },
            child: Stack(
              children: <Widget>[
                ModalProgressHUD(
                    inAsyncCall: _inAsyncCall,
                    progressIndicator: CircularProgressIndicator(),
                    opacity: 0.1,
                    child: Container(
//                      color : Colors.red,
//                  height: double.infinity,
                        alignment: Alignment.center,
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: DragTarget(
                                  builder: (context, List<Sticker> candidateData, rejectedData) {
                                    PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
                                    return GestureDetector(
                                      onScaleStart: (details) {},
                                      onScaleUpdate: (details) {
                                        print(details.scale);
                                        if (placeStatus.selectedSticker == null) {
                                          return;
                                        }

                                        placeStatus.updateStickerScale(details.scale);
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          placeStatus.selectSticker(placeStatus.selectedSticker.id);
                                        },
                                        child: Container(
                                          key: _keyStickerBackground,
                                          color: Color(0xFFFFF385),
                                          child: AspectRatio(
                                              aspectRatio: 9 / 18,
                                              child: Stack(
                                                  children: placeStatus.placedStickerList.map((x) {
//                                                          print(x.sticker.path);
                                                return x;
                                              }).toList())),
                                        ),
                                      ),
                                    );
                                  },
                                  onWillAccept: (data) {
                                    return true;
                                  },
                                  onAccept: (data) {},
                                ),
                              ),
                            ],
                          ),
                        ))),
                SlidingUpPanel(
                  defaultPanelState: PanelState.OPEN,
                  minHeight: _panelHeightClosed,
                  maxHeight: _panelHeightOpen,
                  controller: _pc,
                  panel: _buildUnderStickerBox(),
                  onPanelSlide: (double pos) => setState(() {
                    _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
                  }),
                ),

//                Positioned.fill(
//                  bottom : _fabHeight,
//                  child:
//
//                ),

                Positioned(
                  right: 0.0,
                  bottom: _fabHeight,
                  child: _buildUtilButtons(),
                ),
              ],
            ),
          )),
    );
  }
}

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
