import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tune extends StatelessWidget {
  const Tune({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Tunning",style: TextStyle(
        color: Colors.orangeAccent)),),
    );
  }
}