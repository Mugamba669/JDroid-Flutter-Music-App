import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Room extends StatefulWidget {
  const Room({Key key}) : super(key: key);
  @override
  _Room createState( ) => _Room();
}

class _Room extends State<Room>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Room Effects",style: TextStyle(
        color: Colors.orangeAccent)),)
    );
  }
}