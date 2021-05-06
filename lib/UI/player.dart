import 'dart:io';

import 'package:app/Eq/equal.dart';
import 'package:app/home.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:image_picker/image_picker.dart';

class Player extends StatefulWidget {
  Player({Key key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context,Orientation orientation){
      return orientation == Orientation.portrait ? Portrait() : LandScape();
    });
  }
}

class Portrait extends StatefulWidget {
  final int index;
  Portrait({Key key,this.index}) : super(key: key);

  @override
  _PortraitState createState() => _PortraitState();
}

class _PortraitState extends State<Portrait> {
  bool _isVisible = true;
  bool _isShuffle = true;
  GlobalKey<ScaffoldState> _drawer = GlobalKey<ScaffoldState>();
  double _value = 10;
  var picker = ImagePicker();
  File _image;
  void getImage()async{
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickFile != null){
      _image = File(pickFile.path);
      print(pickFile.path);
    }else{
      print("Image not selected");
    }
    });
  }
 AudioPlayer player;
 AudioCache cached;
Duration position = new Duration();
Duration musiclength = new Duration();
FlutterAudioQuery songs = new FlutterAudioQuery();
List<SongInfo> tracks;

void MusicJams(



































































































































































































































































































































































































































































































































































































































































































































































































































































































  
),
  @override
 void initState() async{ 
   super.initState();
    tracks = await songs.getSongs();
   player = AudioPlayer();
   cached = AudioCache(fixedPlayer: player);
   player.durationHandler = (d){
     setState(() {
       musiclength = d;
     });
   };
   player.positionHandler = (d){
     setState(() {
       position = d;
     });
   };
   cached.load(tracks[widget.index].filePath);
 }
 void seekToSec(var sec){
   Duration posSec = Duration(seconds: sec);
   player.seek(posSec);
 }
 @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
  // void playControls()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_drawer,
      // backgroundColor: Colors.black.withOpacity(0),
      body:SafeArea(
        child: Column(
          children: [
          Card(
            elevation: 15.0,
            margin: EdgeInsets.all(0),
            child: Stack(
              children: [
                Image(
                  image: AssetImage("images/water.jpeg"),
                  width:MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  height:MediaQuery.of(context).size.height / 2,
                ),
                Positioned(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:Colors.black,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){},
                     icon: Icon(Icons.shuffle,
                     color: Colors.orangeAccent,)),
                     
                  ),
                  bottom: 5,
                  left:5,
                  ),
                Positioned(
                  child: Visibility(
                    visible: _isShuffle,
                    child:CircleAvatar(
                    radius: 20,
                    backgroundColor:Colors.black,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState(() {
                          _isShuffle = !_isShuffle;

                          SnackBar(
                            backgroundColor: Colors.black54,
                            duration: Duration(seconds: 3),
                          content:Row(
                            children: [
                                Icon(Icons.done),
                                Text("Shuffle is off")
                          ],),
                          );
                        });
                        
                        
                     
                      },
                     icon: Icon(Icons.repeat,
                     color: Colors.white54,)),
                     
                  ),
                  replacement:CircleAvatar(
                    radius: 20,
                    backgroundColor:Colors.black,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                       
                        
                          setState(() {
                          _isShuffle = !_isShuffle;

                          
                           return SnackBar(
                             backgroundColor: Colors.black54,
                            duration: Duration(seconds: 3),
                          content:Row(
                            children: [
                                Icon(Icons.done),
                                Text("Shuffle is on")
                          ],),
                          );
                        });
                      },
                     icon: Icon(Icons.repeat_rounded,color: Colors.orangeAccent,
                     )),
                  ),
                  ),
                  bottom: 5,
                  left:MediaQuery.of(context).size.width / 2.5,
                  ),
                   Positioned(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:Colors.black,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        // showModalBottomSheet(context: context, builder: builder)
                        showDialog(
                          // backgroundColor: Colors.transparent,
                        context: context, 
                        builder: (context){
                          return Dialog(
                            // onClosing: (){},
                            elevation: 20.0,
                            backgroundColor:Colors.transparent,
                           child: Container(
                              padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                width: 1000,
                                height: 1000,
                                child: ListView(
                                  children: [

                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text("Track Info",style: TextStyle(color: Colors.orangeAccent)),
                                      ),
                                      Divider(color: Colors.orangeAccent,thickness: 0.5,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image(
                                              image: AssetImage("images/water.jpeg"),
                                              width: 100,
                                              height: 100,

                                            ),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:BorderRadius.circular(10),
                                                color: Colors.orangeAccent
                                              ),
                                              child: TextButton.icon(
                                                onPressed: (){
                                                      getImage();
                                                },
                                               icon: Icon(Icons.add_a_photo_rounded,color: Colors.black,), 
                                               label: Text("Edit",style: TextStyle(color: Colors.black))),
                                            ),
                                        ],),
                                        
                                        Divider(color: Colors.orangeAccent,thickness: 0.5,),
                                         ListTile(
                                          leading: Text("Track Artist",style: TextStyle(color: Colors.orangeAccent)),
                                          title: Text("Artist name  appears here....",style: TextStyle(color: Colors.orangeAccent)),
                                        ),
                                        Divider(color: Colors.orangeAccent,thickness: 0.5,),
                                         ListTile(
                                          leading: Text("Album :",style: TextStyle(color: Colors.orangeAccent)),
                                          title: Text("Track Album name appears here....",style: TextStyle(color: Colors.orangeAccent)),
                                        ),
                                         Divider(color: Colors.orangeAccent,thickness: 0.5,),
                                         ListTile(
                                          leading: Text("Year:",style: TextStyle(color: Colors.orangeAccent)),
                                          title: Text("Track year appears here....",style: TextStyle(color: Colors.orangeAccent)),
                                        ),
                                         Divider(color: Colors.orangeAccent,thickness: 0.5,),
                                         ListTile(
                                          leading: Text("Composer:",style: TextStyle(color: Colors.orangeAccent)),
                                          title: Text("Composer name appears here....",style: TextStyle(color: Colors.orangeAccent)),
                                        ),
                                  ],
                                ),
                              ),
                          );
                        });
                      },
                     icon: Icon(Icons.more_vert_rounded,
                     color: Colors.orangeAccent,)),
                     
                  ),
                  bottom: 5,
                  left:MediaQuery.of(context).size.width / 1.2,
                  ),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,

                      child: IconButton(
                        icon: Icon(Icons.menu,color:Colors.orangeAccent),
                        onPressed: (){
                              _drawer.currentState.openDrawer();
                        },
                        ),
                    ),),
              ],
            ),
          ),
          ListTile(
            title: Text("Track Title",style: TextStyle(color: Colors.orangeAccent),),
            subtitle: Text("Artist - Album",style: TextStyle(color: Colors.orangeAccent)),
            trailing: Visibility(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:Colors.black87
                ),
                child: IconButton(
                  onPressed: (){
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                   builder:(context){
                     return BottomSheet(
                       backgroundColor: Colors.transparent,
                       onClosing: (){},
                      builder: (context){
                        return Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)
                            )
                          ),
                          height:100,
                          child: Center(
                            child: Column(
                              children: [
                                Text("Track Added to favourites",style: TextStyle(
                                  color: Colors.orangeAccent),
                                  ),
                                TextButton.icon(onPressed: (){},
                                 icon: Icon(Icons.done), label: Text("Done",style: TextStyle(color: Colors.orangeAccent)))
                              ],
                            ),
                            ),
                        );
                      });
                   });
                },
                 icon: Icon(Icons.thumb_up,color: Colors.orangeAccent,),),
              ),
            
              ),
          ),
          // CupertinoSlider(
          //    min: 0,
          // max: 100,
          //   value: _value,
          //  onChanged: (value){
          //    setState(() {
          //      _value = value;
          //    });
          //  }),
         Slider(
           divisions: 100,
           inactiveColor: Colors.orangeAccent,
           activeColor: Colors.black87,
           label: "$_value",
           autofocus: true,
           focusNode: FocusNode(debugLabel: "Proto"),
            min: 0,
          max: position.inSeconds.toDouble(),
           value: _value, 
          onChanged: (value){
              setState(() {
                seekToSec(value);
                _value = value;
              });
          },
         
          ),
        // SfSlider(
        //        min: 0.0,
        //       max: 100.0,
        //       value: _value,
        //       interval: 20,
        //       showTicks: true,
        //       showLabels: true,
        //       enableTooltip: true,
        //       minorTicksPerInterval: 1,
        //       onChanged: (value){
        //         setState((){
        //               _value = value;
        //         });
        //       },),
          Row(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                    backgroundColor: Colors.black87,
                  child: IconButton(
                    onPressed: (){},
                   icon: Icon(Icons.fast_rewind_rounded,
                   color: Colors.orangeAccent,))
                ),
              Visibility(
                visible:_isVisible,
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  radius: 32,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      setState(() {
                        // cached.play(fileName)
                        player.play(tracks[widget.index].filePath);
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: Icon(Icons.play_arrow_rounded,
                    size: 43,color: Colors.orangeAccent,),
                  ),
                ),
                replacement: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.black87,
                  child: IconButton(
                     padding: EdgeInsets.zero,
                    onPressed: (){
                        setState(() {
                        _isVisible = !_isVisible;
                        player.pause();

                      });
                    },
                   icon: Icon(Icons.pause_rounded,
                   size: 43,
                   color: Colors.orangeAccent,)),
                ),
              ),
              CircleAvatar(
                    backgroundColor: Colors.black87,
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        
                      });
                    },
                   icon: Icon(Icons.fast_forward_rounded,color: Colors.orangeAccent,)),
                ),
            ],
          )
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: (){
            Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => Equal(),
                        fullscreenDialog: true
                      ),
                      );

        },
        icon: Icon(Icons.equalizer,color: Colors.orangeAccent,),
       label: Text("Equalizer",style:TextStyle(
         color: Colors.orangeAccent,
       ))),
       drawer: Drawer(
         child: Container(
           color:Colors.black87,
           child: ListView(
             children: [
               UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                 accountName:Text("Jdroid Player",style:TextStyle(
                   color: Colors.orangeAccent,fontSize: 23
                 )) ,
                  accountEmail: Text("")),
                  ListTile(
                    leading: Icon(Icons.library_music_rounded,
                        color:Colors.orangeAccent),
                    title: Text("Library",style:TextStyle(
                   color: Colors.orangeAccent,
                 )),
                    onTap:(){
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => Home(),
                        fullscreenDialog: true
                      ),
                      );

                    }
                  ),
                  Divider(
                   color: Colors.orangeAccent,thickness: 0.51,
                 ),
                    ListTile(
                    leading: Icon(Icons.delete,
                        color:Colors.orangeAccent),
                    title: Text("Delete",style:TextStyle(
                   color: Colors.orangeAccent,
                 )),
                    onTap:(){
                    }
                  )
             ],
           ),
         ),
         ),
    );
  }
}

class LandScape extends StatefulWidget {
  LandScape({Key key}) : super(key: key);

  @override
  _LandScapeState createState() => _LandScapeState();
}

class _LandScapeState extends State<LandScape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}