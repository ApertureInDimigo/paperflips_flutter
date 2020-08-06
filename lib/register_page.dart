import 'package:flutter/material.dart';
import 'request.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _idController = new TextEditingController();
  final TextEditingController _pwController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration( icon: Icon(Icons.person), hintText: 'id', labelText: 'id', ),

              ),
              TextFormField(
                controller: _pwController,
                decoration: const InputDecoration( icon: Icon(Icons.person), hintText: 'pw', labelText: 'pw', ),

              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration( icon: Icon(Icons.person), hintText: 'name', labelText: 'name', ),

              ),
              RaisedButton(
                  onPressed: () {
                    String id = _idController.text;
                    String pw = _pwController.text;
                    String name = _nameController.text;
                    request r = request("192.168.21.1");
                    r.register(id, pw, name);
                  }
              )
            ],
          ),
        ),

      ),
    );
  }
}
