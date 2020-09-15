//import 'dart:html';

import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
import 'common/auth.dart';
import 'common/color.dart';
import 'common/data_class.dart';

import 'common/provider/userProvider.dart';

import 'common/widgets/dialog.dart';

import 'dart:core';

import 'common/font.dart';
import 'common/ip.dart';
import 'fold_page.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:vibration/vibration.dart';

GlobalKey _keyStickerBackground = GlobalKey();
PanelController _pc = new PanelController();

class PlaceStatus with ChangeNotifier {
  String tempSaveData;
  var loadData;

  bool isLoading;

  List<PlacedSticker> placedStickerList = [];
  List<Sticker> stickerList = [];

  BackgroundColor backgruondColor = BackgroundColor(
    id: 666,
    kind: "빨강",
    name: "개빨감",
    color: Color(0xFFFFF385),
    decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
    isAvailable: true,
  );

  String selectedColorTab = "빨강";
  List<Map<String, dynamic>> colorTabList = [
    {"name": "빨강", "color": Colors.red},
    {"name": "주황", "color": Colors.orange},
    {"name": "노랑", "color": Colors.yellow},
    {"name": "초록", "color": Colors.green},
    {"name": "파랑", "color": Colors.blue},
    {"name": "보라", "color": Colors.purple},
    {"name": "갈색", "color": Colors.brown},
    {"name": "검정", "color": Colors.black},
    {"name": "하양", "color": Colors.white}
  ];

  Map<String, dynamic> colorList = {
    "빨강": [
      BackgroundColor(
        id: 1,
        kind: "빨강",
        name: "개빨감",
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 2,
        kind: "빨강",
        name: "좀빨감",
        decoration: BoxDecoration(
          color: Colors.red[300],
        ),
        isAvailable: true,
      ),
    ],
    "주황": [],
    "노랑": [],
    "초록": [
      BackgroundColor(
        id: 500,
        kind: "초록",
        name: "녹파스텔",
        decoration: BoxDecoration(
          color: Color(0xFFC2DCC9),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 501,
        kind: "초록",
        name: "흑녹파스텔",
        decoration: BoxDecoration(
          color: Color(0xFFCEDCC2),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 502,
        kind: "초록",
        name: "광녹파스텔",
        decoration: BoxDecoration(
          color: Color(0xFF87C999),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 503,
        kind: "초록",
        name: "광녹색",
        decoration: BoxDecoration(
          color: Color(0xFF6EDE8C),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 504,
        kind: "초록",
        name: "녹색",
        decoration: BoxDecoration(
          color: Color(0xFF49C86B),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 505,
        kind: "초록",
        name: "백광녹색",
        decoration: BoxDecoration(
          color: Color(0xFFC8FFDE),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 506,
        kind: "초록",
        name: "형광파스텔",
        decoration: BoxDecoration(
          color: Color(0xFF91F8AD),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 508,
        kind: "초록",
        name: "형광녹색",
        decoration: BoxDecoration(
          color: Color(0xFF4BFF00),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 509,
        kind: "초록",
        name: "연잎색",
        decoration: BoxDecoration(
          color: Color(0xFF92CE5F),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 510,
        kind: "초록",
        name: "잎색",
        decoration: BoxDecoration(
          color: Color(0xFF00AD45),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 511,
        kind: "초록",
        name: "잔디색",
        decoration: BoxDecoration(
          color: Color(0xFF4EB168),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 512,
        kind: "초록",
        name: "스카이민트",
        decoration: BoxDecoration(
          color: Color(0xFF0ABFB3),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 513,
        kind: "초록",
        name: "민트색",
        decoration: BoxDecoration(
          color: Color(0xFF00A78E),
        ),
        isAvailable: true,
      ),
    ],
    "파랑": [
      BackgroundColor(
        id: 3,
        kind: "파랑",
        name: "개파람",
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 4,
        kind: "파랑",
        name: "좀파람",
        color: Colors.red,
        decoration: BoxDecoration(
          color: Colors.blue[300],
        ),
        isAvailable: true,
      ),
    ],
    "보라": [],
    "갈색": [],
    "검정": [],
    "하양": [],
    "흑우": [
      BackgroundColor(
        id: 9999,
        kind: "흑우",
        name: "스페셜",
        color: Colors.red,
        decoration: BoxDecoration(
          gradient: SweepGradient(
            colors: [Colors.blue, Colors.green, Colors.yellow, Colors.red, Colors.blue],
            stops: [0.0, 0.25, 0.5, 0.75, 1],
          ),
        ),
        isAvailable: true,
      )
    ]
  };

  double defualtStickerWidth = 50;

  bool isStickerPanel = true;

  bool isCollectionLoading = false;

  PlaceStatus() {
    setStickerList();
  }

  void setSelectedColorTab(value) {
    selectedColorTab = value;
    notifyListeners();
  }

  void setBackgroundColor(value) {
    backgruondColor = value;
    notifyListeners();
  }

  void setStickerList() async {
    isCollectionLoading = true;
    isLoading = true;
    notifyListeners();

    final res = await http
        .get("https://paperflips-server.herokuapp.com/User/GetCollection", headers: {"Cookie": "user=" + await getToken()});
    print(res.headers);

    if(res.statusCode != 200){
      stickerList = [];

    }else{
      Map<String, dynamic> resData = jsonDecode(res.body);
      var data = resData["data"];

      var collectionList = data.map<RecipeCard>((x) => RecipeCard.fromJson(x)).toList();

      stickerList = collectionList
          .map<Sticker>((x) => Sticker(
          id: x.recipeSeq,
          name: x.recipeName,
//              path: x.path,
          path : "https://orangemushroom.files.wordpress.com/2017/09/maplestory-256x256.png",
          limit: 9,
          count: 0))
          .toList();
    }





    isCollectionLoading = false;

//    stickerList = [
//      Sticker(id: 1, name: "종이배", path: '${IP.address}/img/image/종이배.png', limit: 9, count: 0),
//      Sticker(id: 2, name: "코끼리", path: '${IP.address}/img/image/코끼리.png', limit: 5, count: 0),
//      Sticker(id: 3, name: "황구리", path: '${IP.address}/img/image/황금개구리.png', limit: 1, count: 0),
//    ];

    loadStatus();

    notifyListeners();
  }

  PlacedSticker selectedSticker;

  getSave() {
    final RenderBox renderBox = _keyStickerBackground.currentContext.findRenderObject();
    double renderBoxWidth = renderBox.size.width;
    double renderBoxHeight = renderBox.size.height;

    var data = placedStickerList.where((x) => x.visible == true).toList().map((x) => x.toJson()).toList();
    log(jsonEncode({
      "renderBoxWidth": renderBoxWidth,
      "renderBoxHeight": renderBoxHeight,
      "data": data,
      "backgroundColor": backgruondColor.id
    }));

    var tempSaveData2 = jsonEncode({
      "renderBoxWidth": renderBoxWidth,
      "renderBoxHeight": renderBoxHeight,
      "data": data,
      "backgroundColor": backgruondColor.id
    });

    return tempSaveData2;
  }




  Future<bool> saveCurrentStatus() async {


    var saveData =  getSave();


    var storage = FlutterSecureStorage();
    var loadData = await storage.read(key: "loadData");
    int seq = jsonDecode(loadData)["seq"];
    print(seq);

    print(saveData);

    final res = await http
        .put("https://paperflips-server.herokuapp.com/User/RoomDataChange/${seq}", headers: {"Cookie": "user=" + await getToken()}, body:{"Data" : saveData});
    print(res.headers);

    print(res.statusCode);

    tempSaveData = saveData;

    return true;
  }

  void loadStatus() async {
    final RenderBox renderBox = _keyStickerBackground.currentContext.findRenderObject();
    double renderBoxWidth = renderBox.size.width;
    double renderBoxHeight = renderBox.size.height;
    final positionStickerBackground = renderBox.localToGlobal(Offset.zero);
//    var loaded = jsonDecode(
//        '{"renderBoxWidth":358.85714285714283,"renderBoxHeight":717.7142857142857,"data":[{"id":0,"initPos":{"dx":87.62323288690476,"dy":245.82061434659056},"initScale":1.0,"sticker":{"id":2,"name":"코끼리","path":"https://paperflips-server.herokuapp.com/img/image/코끼리.png","limit":5}},{"id":1,"initPos":{"dx":81.32886904761901,"dy":159.5325947641472},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":2,"initPos":{"dx":165.03841145833331,"dy":97.2551115052189},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":3,"initPos":{"dx":243.04287574404785,"dy":241.18461681547592},"initScale":1.0,"sticker":{"id":3,"name":"황구리","path":"https://paperflips-server.herokuapp.com/img/image/황금개구리.png","limit":1}}]}');
//    var loaded = jsonDecode(
//        '{"backgroundColor":9999, "renderBoxWidth":358.85714285714283,"renderBoxHeight":717.7142857142857,"data":[{"id":0,"initPos":{"dx":154.18154761904762,"dy":159.79871144480478},"initScale":1.0,"sticker":{"id":2,"name":"코끼리","path":"https://paperflips-server.herokuapp.com/img/image/코끼리.png","limit":5}},{"id":1,"initPos":{"dx":156.19047619047618,"dy":214.66896814123345},"initScale":1.0,"sticker":{"id":2,"name":"코끼리","path":"https://paperflips-server.herokuapp.com/img/image/코끼리.png","limit":5}},{"id":2,"initPos":{"dx":158.47563244047618,"dy":267.2422103287334},"initScale":1.0,"sticker":{"id":2,"name":"코끼리","path":"https://paperflips-server.herokuapp.com/img/image/코끼리.png","limit":5}},{"id":3,"initPos":{"dx":154.4789806547619,"dy":325.8209597195037},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":4,"initPos":{"dx":105.33556547619045,"dy":325.79515056771817},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":5,"initPos":{"dx":43.90001860119045,"dy":330.1052789159327},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":6,"initPos":{"dx":210.18908110119045,"dy":327.8082644070038},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":7,"initPos":{"dx":266.1754092261907,"dy":326.9307532462897},"initScale":1.0,"sticker":{"id":1,"name":"종이배","path":"https://paperflips-server.herokuapp.com/img/image/종이배.png","limit":9}},{"id":8,"initPos":{"dx":128.6974621414766,"dy":84.27572665040529},"initScale":1.9627674369599777,"sticker":{"id":3,"name":"황구리","path":"https://paperflips-server.herokuapp.com/img/image/황금개구리.png","limit":1}}]}');

    var storage = FlutterSecureStorage();
    var loaded = jsonDecode(await storage.read(key: "loadData"))["Data"];
    print(loaded);

    double widthRatio = renderBoxWidth / loaded["renderBoxWidth"];
    double heightRatio = renderBoxHeight / loaded["renderBoxHeight"];
    print(widthRatio);
    print(heightRatio);

    List<PlacedSticker> data = loaded["data"].map<PlacedSticker>((x) => PlacedSticker.fromJson(x)).toList();

    for (int i = 0; i < stickerList.length; i++) {
      try {
        stickerList[i].limit = data.where((x) => x.sticker.id == stickerList[i].id).toList()[0].sticker.limit;
      } catch (e) {}

      stickerList[i].count = 0;
    }
    for (int i = 0; i < data.length; i++) {
      data[i].sticker = stickerList.where((x) => x.id == data[i].sticker.id).toList()[0];
      data[i].sticker.count += 1;

      data[i].position = Offset(data[i].initPos.dx * widthRatio, data[i].initPos.dy * heightRatio);
    }

    for (int i = 0; i < data.length; i++) {
      print(data[i].position);
    }
    for (int i = 0; i < stickerList.length; i++) {}

    defualtStickerWidth = 50 * widthRatio;
    print(defualtStickerWidth);
    placedStickerList = data;

    for (var colorTab in colorList.keys) {
      for (BackgroundColor color in colorList[colorTab]) {
        if (color.id == loaded["backgroundColor"]) {
          backgruondColor = color;
        }
      }
    }

    isLoading = false;
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

      return true;
    });

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
  }

  void addSticker(PlacedSticker placedSticker) {
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

class BackgroundColor {
  int id;
  String kind;
  String name;
  Color color;
  int price;
  BoxDecoration decoration;
  bool isAvailable;

  BackgroundColor({int id, String kind, String name, Color color, int price, BoxDecoration decoration, bool isAvailable}) {
    this.id = id;
    this.kind = kind;
    this.name = name;
    if (price != null) {
      this.price = price;
    } else {
      this.price = null;
    }

    if (color != null) {
      this.color = color;
    } else {
      this.color = null;
    }
    if (decoration != null) {
      this.decoration = decoration;
    } else {
      this.decoration = null;
    }

    this.isAvailable = isAvailable;
  }
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

    initScale = json["initScale"].toDouble();
    scale = initScale;

    sticker = Sticker(
        id: json["sticker"]["seq"],
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

//    data['sticker'] = {
//      "id": this.sticker.id,
//      "name": this.sticker.name,
//      "path": this.sticker.path,
//      "limit": this.sticker.limit
//    };

    data['sticker'] = {
      "seq": this.sticker.id,
    };


    print(data);
    return data;
  }

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

class EditMyRoomPage extends StatefulWidget {

  var loadData;

  EditMyRoomPage(this.loadData);

  @override
  _EditMyRoomPageState createState() => _EditMyRoomPageState(loadData);
}

class _EditMyRoomPageState extends State<EditMyRoomPage> {

  _EditMyRoomPageState(_loadData){
    loadData = _loadData;
  }


  var loadData;
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
            height: 40,
//            width : 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 30,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Material(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      onTap: () {


                        showCustomDialog(
                            context: context,
                            title: "저장할까요?",
                            content: "저장하면 좋아용",
                            cancelButtonText: "취소",
                            confirmButtonText: "저장",
                            cancelButtonAction: () {
                              Navigator.pop(context);
                            },
                            confirmButtonAction: () async {
                              bool saveResult = await placeStatus.saveCurrentStatus();
                              Navigator.pop(context);
                              if(saveResult == true){
                                showCustomAlert(context:context, title:"저장 됐어요!", duration: Duration(seconds: 1));
                              }
                            });
                        
                        
                        
              
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        child: Icon(Icons.save, size: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Material(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      onTap: () {
//                        placeStatus.loadStatus();

                        showCustomDialog(
                            context: context,
                            title: "스티커를 모두 지울까요?",
                            content: "현재 배치되어 있는 모든 스티커들이 서랍으로 되돌아갑니다.",
                            cancelButtonText: "취소",
                            confirmButtonText: "초기화",
                            cancelButtonAction: () {
                              Navigator.pop(context);
                            },
                            confirmButtonAction: () {
                              placeStatus.clear();
                              Navigator.pop(context);
                              showCustomAlert(context:context, title:"모두 지워졌어요!", duration: Duration(seconds: 1));
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        child: Icon(
                          Icons.delete_forever,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
//                Container(
//                  width : 30,
//                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                  child: Material(
//                    color: Colors.white.withOpacity(0.8),
//                    borderRadius: BorderRadius.all(Radius.circular(5)),
//                    child: InkWell(
//                      borderRadius: BorderRadius.all(Radius.circular(5)),
//                      onTap: () {
//                        placeStatus.loadStatus();
//                      },
//                      child: Container(
//                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//                        child:  Icon(Icons.cloud_download, size: 20,),
//                      ),
//                    ),
//                  ),
//                ),
                Container(
                  width: 30,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Material(
                    color: placeStatus.isStickerPanel ? Colors.white.withOpacity(0.8) : Colors.grey[400].withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      onTap: () {
                        _pc.open();
                        placeStatus.isStickerPanel = !placeStatus.isStickerPanel;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        child: placeStatus.isStickerPanel
                            ? Icon(
                                Icons.format_paint,
                                size: 20,
                              )
                            : Icon(
                                Icons.close,
                                size: 20,
                              ),
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

                            return Draggable(
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
                    width: 35,
                    height: 4,
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
                  child: !placeStatus.isCollectionLoading
                      ? Container(
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
                        )
                      : Center(child: CircularProgressIndicator()),
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
      child: Builder(
        builder: (context){
          PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
          return WillPopScope(
            onWillPop: (){

              if(placeStatus.getSave() != placeStatus.tempSaveData){
                showCustomDialog(
                    context: context,
                    title: "정말로 나가실래요?",
                    content: "저장하지 않은 변경 사항은 사라집니다.",
                    cancelButtonText: "취소",
                    confirmButtonText: "나가기",
                    cancelButtonAction: () {
                      Navigator.pop(context);
                    },
                    confirmButtonAction: () async{
                      print("SD");

                      Navigator.pop(context);
                      Navigator.pop(context);

                    });
              }else{
                Navigator.pop(context);
              }



              return;
            },
            child: ModalProgressHUD(
              inAsyncCall: placeStatus.isLoading,
              progressIndicator: CircularProgressIndicator(),
              opacity : 0.8,
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
//                        alignment: Alignment.center,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
//                                alignment: Alignment.center,
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
                                                  decoration: placeStatus.backgruondColor.decoration,
                                                  child: AspectRatio(
                                                      aspectRatio: 3 / 5,
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
                        Builder(
                          builder: (context) {
                            PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
                            return SlidingUpPanel(
                              defaultPanelState: PanelState.OPEN,
                              minHeight: _panelHeightClosed,
                              maxHeight: _panelHeightOpen,
                              controller: _pc,
                              panel: placeStatus.isStickerPanel ? _buildUnderStickerBox() : _buildUnderColorBox(),
                              onPanelSlide: (double pos) => setState(() {
                                _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
                              }),
                            );
                          },
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
            ),
          );
        },
      )
    );
  }

  Widget _buildUnderColor(BackgroundColor backgroundColor) {
    return Builder(
      builder: (context) {
        PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
        return Material(
          color: navColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: () {
              if (backgroundColor.isAvailable) {
                placeStatus.setBackgroundColor(backgroundColor);
              }
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 11 / 20,
                      heightFactor: 11 / 20,
                      child: Container(
                        decoration: backgroundColor.decoration,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Builder(builder: (context) {
                      PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
                      return Text(
                        backgroundColor.name,
                        style: TextStyle(fontSize: 11),
                      );
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

  Widget _buildUnderColorBox() {
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
                  width: 35,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
          ),
          Container(
            color: navColor,
            height: 30,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: placeStatus.colorTabList.map<Widget>((x) {
                  return Expanded(
                    child: Material(
                      color: placeStatus.selectedColorTab == x["name"] ? Colors.white : navColor,

                      borderRadius: BorderRadius.all(Radius.circular(1000)),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                        onTap: () {
                          placeStatus.setSelectedColorTab(x["name"]);
                        },
                        child: Container(
//                          alignment: Alignment.center,
//                          height : 30,



                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 8,
                                height: 8,
                                decoration:
                                    BoxDecoration(
                                        border : placeStatus.selectedColorTab == x["name"] && x["name"] == "하양" ? Border.all(
                                          color : Colors.black,
                                          width : 1,
                                        ) : null,
                                        borderRadius: BorderRadius.all(Radius.circular(1000)), color: x["color"]),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                x["name"],
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList()),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            height: 240,
            child: Column(children: [
              Flexible(
                child: Container(
//            height : 250,
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),

                  child: GridView.count(
//        physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    //스크롤 방향 조절
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 5,

                    children:
                        placeStatus.colorList[placeStatus.selectedColorTab].map<Widget>((x) => _buildUnderColor(x)).toList(),
                  ),
                ),
              ),
            ]),
          ),
        ]);
      },
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
