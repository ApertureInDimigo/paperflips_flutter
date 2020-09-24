import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/common/data_class.dart';
import 'package:flutter_front/common/widgets/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipedetector/swipedetector.dart';
import 'dart:convert';
import 'common/auth.dart';
import 'common/color.dart';
import 'common/data_class.dart';
import 'common/widgets/dialog.dart';
import 'dart:core';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vibration/vibration.dart';

GlobalKey _keyStickerBackground = GlobalKey();
PanelController _pc = new PanelController();

class PlaceStatus with ChangeNotifier {
  String tempSaveData;
  var loadData;
  int count;
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
        name: "빨강",
        decoration: BoxDecoration(
          color: Color(0xFFeb4034),
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 2,
        kind: "빨강",
        name: "분홍",
        decoration: BoxDecoration(
          color: Colors.red[300],
        ),
        isAvailable: true,
      ),
    ],
    "주황": [
      BackgroundColor(
        id: 101,
        kind: "주황",
        name: "주황",
        decoration: BoxDecoration(
          color: Colors.orange,
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 102,
        kind: "주황",
        name: "연주황",
        decoration: BoxDecoration(
          color: Colors.orange[300],
        ),
        isAvailable: true,
      ),
    ],
    "노랑": [
      BackgroundColor(
        id: 201,
        kind: "노랑",
        name: "노랑",
        decoration: BoxDecoration(
          color: Colors.yellow,
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 202,
        kind: "노랑",
        name: "연노랑",
        decoration: BoxDecoration(
          color: Colors.yellow[300],
        ),
        isAvailable: true,
      ),
    ],
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
        id: 601,
        kind: "파랑",
        name: "파랑",
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 602,
        kind: "파랑",
        name: "하늘",
        decoration: BoxDecoration(
          color: Colors.blue[300],
        ),
        isAvailable: true,
      ),
    ],
    "보라": [
      BackgroundColor(
        id: 701,
        kind: "보라",
        name: "보라",
        decoration: BoxDecoration(
          color: Colors.purple,
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 702,
        kind: "파랑",
        name: "연보라",
        decoration: BoxDecoration(
          color: Colors.purple[300],
        ),
        isAvailable: true,
      ),
    ],
    "갈색": [
      BackgroundColor(
        id: 801,
        kind: "갈색",
        name: "갈색",
        decoration: BoxDecoration(
          color: Colors.brown,
        ),
        isAvailable: true,
      ),
      BackgroundColor(
        id: 802,
        kind: "갈색",
        name: "연갈색",
        decoration: BoxDecoration(
          color: Colors.brown[300],
        ),
        isAvailable: true,
      ),
    ],
    "검정": [
      BackgroundColor(
        id: 901,
        kind: "검정",
        name: "검정",
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        isAvailable: true,
      ),
    ],
    "하양": [
      BackgroundColor(
        id: 1001,
        kind: "하양",
        name: "하양",
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        isAvailable: true,
      ),
    ],
    "흑우": [
      BackgroundColor(
        id: 9999,
        kind: "흑우",
        name: "스페셜",
        color: Colors.red,
        decoration: BoxDecoration(
          gradient: SweepGradient(
            colors: [
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.red,
              Colors.blue
            ],
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

    final res = await http.get(
        "https://paperflips-server.herokuapp.com/User/GetCollection",
        headers: {"Cookie": "user=" + await getToken()});
    print(res.headers);

    if (res.statusCode != 200) {
      stickerList = [];
    } else {
      Map<String, dynamic> resData = jsonDecode(res.body);
      var data = resData["data"];

      var collectionList =
          data.map<RecipeCard>((x) => RecipeCard.fromJson(x)).toList();

      stickerList = collectionList
          .map<Sticker>((x) => Sticker(
              id: x.recipeSeq,
              name: x.recipeName,
              path:
                  "https://paperflips.s3.amazonaws.com/recipe_img/${x.recipeSeq}.png",
              limit: 9,
              count: 0))
          .toList();
    }

    isCollectionLoading = false;

    loadStatus();

    notifyListeners();
  }

  PlacedSticker selectedSticker;

  getSave() {
    final RenderBox renderBox =
        _keyStickerBackground.currentContext.findRenderObject();
    double renderBoxWidth = renderBox.size.width;
    double renderBoxHeight = renderBox.size.height;

    var data = placedStickerList
        .where((x) => x.visible == true)
        .toList()
        .map((x) => x.toJson())
        .toList();

    var tempSaveData2 = jsonEncode({
      "renderBoxWidth": renderBoxWidth,
      "renderBoxHeight": renderBoxHeight,
      "data": data,
      "backgroundColor": backgruondColor.id
    });

    return tempSaveData2;
  }

  Future<bool> saveCurrentStatus() async {
    var saveData = getSave();

    var storage = FlutterSecureStorage();
    var loadData = await storage.read(key: "loadData");
    int seq = jsonDecode(loadData)["seq"];
    print(seq);

    print(jsonDecode(saveData));

    final res = await http.put(
        "https://paperflips-server.herokuapp.com/User/RoomDataChange/${seq}",
        headers: {
          "Cookie": "user=" + await getToken(),
          "Content-Type": 'application/json'
        },
        body: jsonEncode({"Data": jsonDecode(saveData)}));
    print(res.headers);

    print(res.statusCode);
    if (res.statusCode == 200) {
      tempSaveData = saveData;

      var loadData2 = jsonDecode(loadData);
      loadData2["Data"] = jsonDecode(saveData);
      storage.write(key: "loadData", value: jsonEncode(loadData2));
    }

    return true;
  }

  void loadStatus() async {
    final RenderBox renderBox =
        _keyStickerBackground.currentContext.findRenderObject();
    double renderBoxWidth = renderBox.size.width;
    double renderBoxHeight = renderBox.size.height;

    var storage = FlutterSecureStorage();
    var loaded = jsonDecode(await storage.read(key: "loadData"))["Data"];
    print(loaded);

    double widthRatio = renderBoxWidth / loaded["renderBoxWidth"];
    double heightRatio = renderBoxHeight / loaded["renderBoxHeight"];
    print(widthRatio);
    print(heightRatio);

    List<PlacedSticker> data = loaded["data"]
        .map<PlacedSticker>((x) => PlacedSticker.fromJson(x))
        .toList();
    List<int> temp = [];
    for (int i = 0; i < stickerList.length; i++) {
      try {
        stickerList[i].limit = data
            .where((x) => x.sticker.id == stickerList[i].id)
            .toList()[0]
            .sticker
            .limit;
      } catch (e) {}

      stickerList[i].count = 0;
    }

    for (int i = 0; i < data.length; i++) {
      data[i].sticker =
          stickerList.where((x) => x.id == data[i].sticker.id).toList()[0];
      data[i].sticker.count += 1;

      data[i].position = Offset(
          data[i].initPos.dx * widthRatio, data[i].initPos.dy * heightRatio);

      temp.add(data[i].id);
    }

    if (temp.length > 0) {
      count = temp.reduce(max) + 1;
    } else {
      count = 1;
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
        ? (defualtStickerWidth * afterScale >= 20
            ? afterScale
            : 20 / defualtStickerWidth)
        : 150 / defualtStickerWidth;

    selectedSticker.scale = afterScale;
    selectedSticker.position = Offset(
        selectedSticker.position.dx -
            (defualtStickerWidth * (afterScale - currentScale) / 2),
        selectedSticker.position.dy -
            (defualtStickerWidth * (afterScale - currentScale) / 2));
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
        id: json["sticker"]["seq"], limit: 9, name: "임시", path: "임시", count: 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['initPos'] = {"dx": this.position.dx, "dy": this.position.dy};

    data['initScale'] = this.scale;
    print(this.scale);

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
  _PlacedStickerState createState() =>
      _PlacedStickerState(id, initPos, initScale, sticker);
}

class _PlacedStickerState extends State<PlacedSticker> {
  int id;
  Offset initPos;
  double initScale;

  Sticker sticker;
  bool _isPanelOpen;

  _PlacedStickerState(
      int _id, Offset _initPos, double _initScale, Sticker _sticker) {
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
    PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
    return Positioned(
      key: GlobalKey(),
      left: widget.position.dx,
      top: widget.position.dy,
      child: Visibility(
        visible: widget.visible,
        child: GestureDetector(
          onScaleStart: (details) {},
          onTap: () async {
            placeStatus.selectSticker(id);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: widget.selected ? Colors.white.withOpacity(0.8) : null,
            ),
            child: Draggable(
                onDragStarted: () {
                  if (_pc.isPanelOpen == true) {
                    _pc.close();
                    _isPanelOpen = true;
                  } else {
                    _isPanelOpen = false;
                  }
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
                    final RenderBox renderBox =
                        _keyStickerBackground.currentContext.findRenderObject();
                    final positionStickerBackground =
                        renderBox.localToGlobal(Offset.zero);
                    placeStatus.moveSticker(
                        id,
                        Offset(data.offset.dx - positionStickerBackground.dx,
                            data.offset.dy - positionStickerBackground.dy));
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
  _EditMyRoomPageState(_loadData) {
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
    _placedStickerList = [];
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildUtilButtons() {
      return Builder(
        builder: (context) {
          PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
          return Container(
            height: 40,
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
                            content: "저장하면 다음에 불러올 수 있어요",
                            cancelButtonText: "취소",
                            confirmButtonText: "저장",
                            cancelButtonAction: () {
                              Navigator.pop(context);
                            },
                            confirmButtonAction: () async {
                              bool saveResult =
                                  await placeStatus.saveCurrentStatus();
                              Navigator.pop(context);
                              if (saveResult == true) {
                                showCustomAlert(
                                    context: context,
                                    title: "저장 됐어요!",
                                    duration: Duration(seconds: 1));
                              }
                            });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0),
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
                              showCustomAlert(
                                  context: context,
                                  title: "모두 지워졌어요!",
                                  duration: Duration(seconds: 1));
                            });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        child: Icon(
                          Icons.delete_forever,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Material(
                    color: placeStatus.isStickerPanel
                        ? Colors.white.withOpacity(0.8)
                        : Colors.grey[400].withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      onTap: () {
                        _pc.open();
                        placeStatus.isStickerPanel =
                            !placeStatus.isStickerPanel;
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0),
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
                                    final RenderBox renderBox =
                                        _keyStickerBackground.currentContext
                                            .findRenderObject();
                                    final positionStickerBackground =
                                        renderBox.localToGlobal(Offset.zero);

                                    placeStatus.addSticker(PlacedSticker(
                                        count++,
                                        Offset(
                                            data.offset.dx -
                                                positionStickerBackground.dx,
                                            data.offset.dy -
                                                positionStickerBackground.dy),
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
              margin: EdgeInsets.all(8),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 35,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
            ),
            Container(
              height: 270,
              child: Column(children: [
                Flexible(
                  child: !placeStatus.isCollectionLoading
                      ? Container(
                          padding: EdgeInsets.only(
                              left: 10, top: 2, right: 10, bottom: 10),
                          child: GridView.count(
                            scrollDirection: Axis.vertical,
                            //스크롤 방향 조절
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 5,
                            children: placeStatus.stickerList
                                .map((x) => _buildUnderSticker(x))
                                .toList(),
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
          builder: (context) {
            PlaceStatus placeStatus = Provider.of<PlaceStatus>(context);
            return WillPopScope(
              onWillPop: () {
                if (placeStatus.getSave() != placeStatus.tempSaveData) {
                  showCustomDialog(
                      context: context,
                      title: "정말로 나가실래요?",
                      content: "저장하지 않은 변경 사항은 사라집니다.",
                      cancelButtonText: "취소",
                      confirmButtonText: "나가기",
                      cancelButtonAction: () {
                        Navigator.pop(context);
                      },
                      confirmButtonAction: () async {
                        print("SD");

                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                } else {
                  Navigator.pop(context);
                }

                return;
              },
              child: ModalProgressHUD(
                inAsyncCall: placeStatus.isLoading,
                progressIndicator: CircularProgressIndicator(),
                opacity: 0.8,
                child: Scaffold(
                    appBar: DefaultAppBar(title: "방 꾸미기"),
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
                                  child: Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: DragTarget(
                                        builder: (context,
                                            List<Sticker> candidateData,
                                            rejectedData) {
                                          PlaceStatus placeStatus =
                                              Provider.of<PlaceStatus>(context);
                                          return GestureDetector(
                                            onScaleStart: (details) {},
                                            onScaleUpdate: (details) {
                                              print(details.scale);
                                              if (placeStatus.selectedSticker ==
                                                  null) {
                                                return;
                                              }

                                              placeStatus.updateStickerScale(
                                                  details.scale);
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                placeStatus.selectSticker(
                                                    placeStatus
                                                        .selectedSticker.id);
                                              },
                                              child: Container(
                                                key: _keyStickerBackground,
                                                decoration: placeStatus
                                                    .backgruondColor.decoration,
                                                child: AspectRatio(
                                                    aspectRatio: 3 / 5,
                                                    child: Stack(
                                                        children: placeStatus
                                                            .placedStickerList
                                                            .map((x) {
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
                              PlaceStatus placeStatus =
                                  Provider.of<PlaceStatus>(context);
                              return SlidingUpPanel(
                                defaultPanelState: PanelState.OPEN,
                                minHeight: _panelHeightClosed,
                                maxHeight: _panelHeightOpen,
                                controller: _pc,
                                color: Colors.white.withOpacity(0.9),
                                panel: placeStatus.isStickerPanel
                                    ? _buildUnderStickerBox()
                                    : _buildUnderColorBox(),
                                onPanelSlide: (double pos) => setState(() {
                                  _fabHeight = pos *
                                          (_panelHeightOpen -
                                              _panelHeightClosed) +
                                      _initFabHeight;
                                }),
                              );
                            },
                          ),
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
        ));
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
                      PlaceStatus placeStatus =
                          Provider.of<PlaceStatus>(context);
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
            margin: EdgeInsets.all(8),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 35,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
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
                      color: placeStatus.selectedColorTab == x["name"]
                          ? Colors.white
                          : navColor,
                      borderRadius: BorderRadius.all(Radius.circular(1000)),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                        onTap: () {
                          placeStatus.setSelectedColorTab(x["name"]);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                    border: placeStatus.selectedColorTab ==
                                                x["name"] &&
                                            x["name"] == "하양"
                                        ? Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          )
                                        : null,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1000)),
                                    color: x["color"]),
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
                  padding:
                      EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    //스크롤 방향 조절
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 5,
                    children: placeStatus
                        .colorList[placeStatus.selectedColorTab]
                        .map<Widget>((x) => _buildUnderColor(x))
                        .toList(),
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
