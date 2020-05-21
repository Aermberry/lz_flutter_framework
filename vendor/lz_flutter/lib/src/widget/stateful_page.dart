import 'package:flutter/material.dart';

class StatefulPage extends StatefulWidget{

  State<StatefulWidget> _state;

  StatefulPage(this._state,{Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _state;
  }

}