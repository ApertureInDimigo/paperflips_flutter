import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../auth.dart';
import '../ip.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
Map<String, dynamic> parseJwtPayLoad(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

Map<String, dynamic> parseJwtHeader(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[0]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}


class UserStatus with ChangeNotifier {

  bool isLogined = false;
  Map<String, dynamic> userInfo = {};

  UserStatus(){
    init();

  }

  Future<bool> login(String id, String pw) async{

    final res = await http.post(
        "${IP.address}/User/login",
        body: {"id": id, "password" : pw});
    print(res.body);
    Map<String, dynamic> data = jsonDecode(res.body);
    if(data["status"]!= 200){
      return false;
    }
    var token = res.headers["set-cookie"].split("user=")[1].split(";")[0];
    print(token);

    var storage = FlutterSecureStorage();
    storage.write(key: "token", value: token);

    isLogined = true;
    userInfo["id"] = parseJwtPayLoad(token)["id"];

    notifyListeners();
//  print();
    return true;
  }

  Future<bool> register(String id, String pw, String name) async{




    final res = await http.post(
      "${IP.address}/User/Adduser",
      body: {
        'id': id,
        'password': pw,
        'name': name
      },
    );

    Map<String, dynamic> data = jsonDecode(res.body);




    print(data);


    if(data["status"] == 200){
      return true;
    }else{
      return false;
    }
  }


  void logout() {
    var storage = FlutterSecureStorage();
    storage.write(key: "token", value: null);
    isLogined = false;
    userInfo = {};

    notifyListeners();
  }


  init() async{
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "token");

    //jwt 토큰이 유효한지 서버에서 가져와야할 것 같은데 일단 생략
    final res = await http.get(
        "https://paperflips-server.herokuapp.com/User/GetCollection",
        headers: {"Cookie" : "user=" + await getToken()}
    );

    Map<String, dynamic> resData = jsonDecode(res.body);
    if(resData["status"] != 200){
      storage.write(key: "token", value: null);
      token = null;
    }




    if(token != null){
      isLogined = true;
      userInfo["id"] = parseJwtPayLoad(token)["id"];
    }else{
      isLogined = false;
    }


    print(token);
    notifyListeners();
  }


}