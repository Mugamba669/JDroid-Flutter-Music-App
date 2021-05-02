import 'dart:async';
import 'dart:ui';

import 'package:app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner:false,
      home: Splash(),
      );
  }
}

class Splash extends StatefulWidget{
  @override
  _Splash createState() => _Splash();
}
class _Splash extends State<Splash>{
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder:(context) => Home(),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      color: Colors.black,
      child: Column(
        children: [
          Center(
            child: Image(image: AssetImage("images/default3.png"),
            fit: BoxFit.contain,),
          ),
          CircularProgressIndicator(
            strokeWidth: 2.0,
          )
        ],
      ),
    );
  }
}