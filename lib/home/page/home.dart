import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';

@provide
class HomePage extends StatelessWidget implements View {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('Hello World !!!'),
      ),
    );
  }

  @override
  BuildContext getContext() => _context;
}
