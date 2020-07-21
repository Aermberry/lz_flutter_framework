import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  @override
  Widget build(BuildContext context) =>
     Scaffold(
      body: Container(
        alignment: Alignment.center,
        child:const Text('Hello World!!!'),
      ),
    );
}
