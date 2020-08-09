import 'package:flutter/material.dart';
import 'common/widgets/appbar.dart';
import 'request.dart';
import 'common/color.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FoldPage extends StatefulWidget {
  @override
  _FoldPageState createState() => _FoldPageState();
}

class _FoldPageState extends State<FoldPage> {

  @override
  void initState() {
    super.initState();

  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title : "접어 그냥"),
    );
  }
}
