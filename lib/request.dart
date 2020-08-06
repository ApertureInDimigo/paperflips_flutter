import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './common/ip.dart';

class request {
  static register(String id, String pwd, String name) async {
    //회원 가입
    var apiUrl = Uri.parse(IP.address + '/AddUser'); //URL
    var client = HttpClient(); // `new` keyword optional

    // 1. Create request
    HttpClientRequest request = await client.postUrl(apiUrl);
    String n = "누구세요";
    // 2. Add payload to request
    var payload = {'id': id, 'password': pwd, 'name': name};
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
