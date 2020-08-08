import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './common/ip.dart';

class request {
  static req(Map<String, String> payload, String api) async {
    Uri apiUrl = Uri.parse(IP.address + api);
    HttpClient client = HttpClient();

    HttpClientRequest request = await client.postUrl(apiUrl);

    request.headers
        .set(HttpHeaders.contentTypeHeader, "aplication/json; charset=utf-8");
    request.write(json.encode(payload));

    HttpClientResponse response = await request.close();

    var resStream = response.transform(Utf8Decoder());
    String d;
    await for (var data in resStream) {
      d = data.toString();
    }
    return d;
  }


  static register(String id, String pwd, String name) async {
    //회원 가입
    var apiUrl = Uri.parse(IP.address + '/User/AddUser'); //URL
    var client = HttpClient(); // `new` keyword optional

    // 1. Create request
    HttpClientRequest request = await client.postUrl(apiUrl);
    // 2. Add payload to request
    Map<String, String> payload = {'id': id, 'password': pwd, 'name': name};
    json.encode(payload);
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=utf-8");
    request.write(json.encode(payload));
    // 3. Send the request
    HttpClientResponse response = await request.close();

    // 4. Handle the response
    var resStream = response.transform(Utf8Decoder());
    String d;
    await for (var data in resStream) {
      d = data.toString();
    }
    print(d);
    parsing(d);
  }

  static parsing(String test) async {
    Respond res = Respond.fromJson(jsonDecode(test));
    print('${res.error}' + ' ' + '${res.status}');
  }
}

class Respond {
  int status;
  int error;

  Respond(this.status, this.error);

  factory Respond.fromJson(dynamic json) {
    return Respond(json['status'] as int, json['error'] as int);
  }
}


