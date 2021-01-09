import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';

@provide
class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if(_scaffoldKey.currentContext != null){
      Config.getInstance()
          .debuggerConfig
          .showDebuggerFloatingButton(_scaffoldKey.currentContext); //防止热更新后context销毁 因此需要用GlobalKey
    }
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          alignment: Alignment.center,
          child: InkWell(
              onTap: () {
                throw (Exception('Test msg'));
              },
              child: Text('Hello World!!!')),
        ));
  }
}
