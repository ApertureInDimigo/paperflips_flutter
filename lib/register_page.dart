import 'package:flutter/material.dart';
import 'request.dart';
import 'common/widgets/appbar.dart';
import 'common/color.dart';
import './common/ip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _idController = new TextEditingController();
  final TextEditingController _pwController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();

  bool _inAsyncCall;

  @override
  void initState() {
    super.initState();
    _inAsyncCall = false;
  }


  void _register(String id, String pw, String name) async{

    setState(() {
      _inAsyncCall = true;
    });


    final res = await http.post(
      "${IP.address}/User/Adduser",
      body: {
        'id': id,
        'password': pw,
        'name': name
      },
    );

    Map<String, dynamic> data = jsonDecode(res.body);






    setState(() {
      _inAsyncCall = false;
    });

    print(data);


    if(data["status"] == 200){

    }else{

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "회원가입"),
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        progressIndicator: CircularProgressIndicator(),
        opacity: 0.2,
        child: Container(
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  height: 45,
                  child: TextField(
                    controller: _idController,
                    onSubmitted: (value) {},
                    onChanged: (value) {},
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: cardColor,
//                    focusColor: Colors.grey,

                      hintText: "아이디를 입력하시던가요ㅋㅋㅋㅋㅋㅋ",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 45,
                  child: TextField(
                    obscureText: true,
                    controller: _pwController,
                    onSubmitted: (value) {},
                    onChanged: (value) {},
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: cardColor,
//                    focusColor: Colors.grey,

                      hintText: "비밀번호를 입력하시던가요ㅋㅋㅋㅋㅋㅋ",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 45,
                  child: TextField(
                    controller: _nameController,
                    onSubmitted: (value) {},
                    onChanged: (value) {},
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: cardColor,
//                    focusColor: Colors.grey,

                      hintText: "이름을 입력하시던가요ㅋㅋㅋㅋㅋㅋ",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Material(
                  color: Color(0xFFE1E1E1),
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () async {
                      String id = _idController.text;
                      String pw = _pwController.text;
                      String name = _nameController.text;

                      _register(id, pw, name);
//                    request.register(id, pw, name);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
//                      border: Border.all(width: 0.4),
                      ),
                      child: Text("회원가입 하던가 ㅋㅋㅋㅋㅋ"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
