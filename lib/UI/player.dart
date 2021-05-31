import 'dart:io';
import 'dart:ui';

// import 'package:app/Eq/eq.dart';
import 'package:app/Eq/equal.dart';
// import 'package:app/Eq/room.dart';
// import 'package:app/Eq/tune.dart';
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

  const Portrait({Key key, this.index}) : super(key: key);


  @override
  _PortraitState createState() => _PortraitState();
}

class _PortraitState extends State<Portrait> {
//  var audioService = AudioService();
 AudioCache cached;
Duration musiclength = new Duration();
  var picker = ImagePicker();
 AudioPlayer player;
Duration position = new Duration();
FlutterAudioQuery songs = new FlutterAudioQuery();
//  List<SongInfo> searchs;
var title = "Unknown Title",
    artist = "Unknown Artist",
    year = "Unknown",
    album = "Unknown Album";

//  var audioManger = AudioManager.instance;
 var trackPath;

 List<SongInfo> tracks;

  GlobalKey<ScaffoldState> _drawer = GlobalKey<ScaffoldState>();
  File _image ;
  bool _isShuffle = true;
  bool _isVisible = true;
double  _scale;
  double _value = 0;

 @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
 void initState(){ 
   super.initState();
   musicTracks();
   player = AudioPlayer();
   cached = AudioCache(fixedPlayer: player);
   // ignore: deprecated_member_use
   player.durationHandler = (d){
     setState(() {
       musiclength = d;
     });
   };
   // ignore: deprecated_member_use
   player.positionHandler = (d){
     setState(() {
       position = d;
     });
   };
   cached.load(tracks[widget.index].filePath);
 }

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

 void seekToSec(var sec){
   Duration posSec = Duration(seconds: sec);
   player.seek(posSec);
 }

 void musicTracks() async {
    tracks = await songs.getSongs();
    // searchs = await songs.searchSongs(query: );
    title = tracks[widget.index].title;
    artist = tracks[widget.index].artist;
    album = tracks[widget.index].album;
    year = tracks[widget.index].year;
    // Room(art: tracks[widget.index].albumArtwork);
    // Tune(art: tracks[widget.index].albumArtwork);
    // Eq(art: tracks[widget.index].albumArtwork);
    
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_drawer,
      // backgroundColor: Colors.black.withOpacity(0),
      body:SafeArea(
        child: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/water.jpeg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
              )
          ),
          child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 15.0,
                margin: EdgeInsets.all(0),
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage("images/water.jpeg"),
                  //  image: FileImage(File(tracks[widget.index].albumArtwork)),
                      width:MediaQuery.of(context).size.width /1.1,
                      fit: BoxFit.cover,
                      height:MediaQuery.of(context).size.height / 2,
                    ),
                    Transform.scale(scale: _scale),
                    Positioned(
                      child: CircleAvatar(
                        radius: 17,
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
                        radius: 17,
                        backgroundColor:Colors.black,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            setState(() {
                              _isShuffle = !_isShuffle;
                            });
                          },
                         icon: Icon(Icons.repeat,
                         color: Colors.white54,)),
                      ),
                      replacement:CircleAvatar(
                        radius: 17,
                        backgroundColor:Colors.black,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                              setState(() {
                              _isShuffle = !_isShuffle; 
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
                        radius: 17,
                        backgroundColor:Colors.black,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            // showCupertinoModalPopup(context: context, builder: builder)
                          showCupertinoModalPopup(
                            filter: ImageFilter.blur(sigmaX: 7,sigmaY: 7),
                            context: context,
                             builder: (context)=> BottomSheet(
                               backgroundColor: Colors.transparent,
                              onClosing: (){}, 
                              builder:(context) => Container(
                                height:MediaQuery.of(context).size.height /1.5,
                                decoration:BoxDecoration(
                                  color:Colors.black26,
                                ),
                                child: ListView(
                                  children: <Widget>[
                                  ListTile(
                                    title: Text("Title : $title",style:TextStyle(color: Colors.white)),
                                  ),
                                  Divider(color: Colors.white,thickness: 0.12,),
                                   ListTile(
                                    title: Text("Artist : $artist",style:TextStyle(color: Colors.white)),
                                  ),
                                  Divider(color: Colors.white,thickness: 0.12,),
                                   ListTile(
                                    title: Text("Album : $album",style:TextStyle(color: Colors.white)),
                                  ),
                                  Divider(color: Colors.white,thickness: 0.12,),
                                   ListTile(
                                    title: Text("Year : $year",style:TextStyle(color: Colors.white)),
                                  ),
                                  Divider(color: Colors.white,thickness: 0.12,),
                               FloatingActionButton(
                                  backgroundColor: Colors.black,
                                    onPressed: () => Navigator.pop(context), 
                                    child: Icon(Icons.arrow_back_ios_rounded,color:Colors.orangeAccent,),
                                    ),
                                // FloatingActionButtonLocation()
                                ],
                              ),
                            )
                          )
                        );
                          },
                         icon: Icon(Icons.more_vert_rounded,
                         color: Colors.orangeAccent,)),
                         
                      ),
                      bottom: 5,
                      left:MediaQuery.of(context).size.width / 1.3,
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
            ),
            ListTile(
              title: Text("$title",style: TextStyle(color: Colors.orangeAccent,backgroundColor:Colors.black),),
              subtitle: Text("$artist - $album",style: TextStyle(color: Colors.orangeAccent,backgroundColor:Colors.black)),
            
            ),
           Slider(
             divisions: 100,
             inactiveColor: Colors.orangeAccent,
             activeColor: Colors.black87,
             label: "$_value",
             autofocus: true,
            //  focusNode: FocusNode(debugLabel: "Proto"),
              min: position.inSeconds.toDouble(),
            max: musiclength.inMinutes.toDouble(),
            // max:100,
             value: _value, 
            onChanged: (value){
                setState(() {
                  seekToSec(value);
                  _value = value;
                });
            },
           
            ),
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
                          _scale = 1.0;
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
                            _scale = 1.5;
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
       label: Text("EQ",style:TextStyle(
         color: Colors.orangeAccent,
       ))),
       drawer: Drawer(
         child: Container(
           padding: EdgeInsets.zero,
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