import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Eq extends StatefulWidget {
  // const Eq({Key key}) : super(key: key);
  _Eq createState() => _Eq();
  
  }

  class _Eq extends State<Eq>{
    double _vl1 = 10,_vl2 = 12, _vl3 = 11, _vl4 = 15;
    bool _expand = false;
    bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SwitchListTile(
          tileColor: Colors.orangeAccent,
          subtitle: Text("This feature allows the user to access the system AudioFx"),
          title: Text("Enable Built-in Audio Fx"),
          value: isOn, 
        onChanged: (value){
         setState(() {
           value = ! value;
         });
        }),
      DropdownButton(
        isExpanded: true,
        hint: Text("Select"),
        onTap: (){
          setState(() {
            _expand = !_expand;
          });
        },
        items: [
        DropdownMenuItem(child: Text("data"))
      ]),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
              SfSlider.vertical(
              value: _vl1,
               min: 0.0,
              max: 100.0,
              interval: 20,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
             onChanged: (value){
               setState(() {
                 _vl1 = value;
               });
             },
            ),

SfSlider.vertical(
              value: _vl1,
               min: 0.0,
              max: 100.0,
              interval: 30,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
             onChanged: (value){
               setState(() {
                 _vl1 = value;
               });
             },
            ),
SfSlider.vertical(
              value: _vl1,
               min: 0.0,
              max: 100.0,
              interval: 20,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
             onChanged: (value){
               setState(() {
                 _vl1 = value;
               });
             },
            ),

            SfSlider.vertical(
              value: _vl1,
               min: 0.0,
              max: 100.0,
              interval: 20,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
             onChanged: (value){
               setState(() {
                 _vl1 = value;
               });
             },
            ),

            // SfSlider.vertical(
            //   value: _vl1,
            //    min: 0.0,
            //   max: 100.0,
            //   interval: 20,
            //   showTicks: true,
            //   showLabels: true,
            //   enableTooltip: true,
            //   minorTicksPerInterval: 1,
            //  onChanged: (value){
            //    setState(() {
            //      _vl1 = value;
            //    });
            //  },
            

        ],
      ),
  
      ],
    );
  }
}