import 'package:flutter/material.dart';
import 'widgets/appbar.dart';
//import 'request.dart';
import 'color.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ip.dart';




void login(String id, String pw) async{

  final res = await http.post(
      "${IP.address}/User/login",
      body: {"id": id, "password" : pw});
  print(res.body);
  Map<String, dynamic> data = jsonDecode(res.body);
  var token = res.headers["set-cookie"].split("user=")[1].split(";")[0];
  print(token);

  var storage = FlutterSecureStorage();
  storage.write(key: "token", value: token);
//  print();
}