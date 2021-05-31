import 'dart:io';
import 'dart:ui';
import 'package:app/music/search.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:equalizer/equalizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
bool playpause = false;
class Songs extends StatefulWidget {
  Songs({Key key}) : super(key: key);

  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("All Songs",style:TextStyle(color:Colors.orangeAccent )),
      ),
      body: SafeArea(
        child:Container(
          decoration: BoxDecoration(
            image:DecorationImage(
                fit: BoxFit.cover,
                image:AssetImage("images/pAudio.jpeg"),
            ),
         ),
          child:BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX:14.0,
              sigmaY: 14.0
            ),
            child:FutureBuilder(
            future: FlutterAudioQuery().getSongs(),
            builder:(context,snapshot){
              List<SongInfo> tracks = snapshot.data;

              if (snapshot.hasData)
                return TrackBuilder(songs: tracks);
              else
               return Padding(
                 padding: const EdgeInsets.only(top:240),
                 child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text("Loading Tracks",
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ) ,
                        ),
                      ),
                    ],
                  ),
              ),
               );
              }
              )
             ,)
            ),
        ),
        floatingActionButton: FloatingActionButton(
          autofocus: true,
          onPressed: (){
             Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  SearchTrack(),
                  fullscreenDialog: true,
                  ),);
          },
          child: Icon(Icons.search_rounded,color:Colors.black),
          backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}

class TrackBuilder extends StatefulWidget {
 final List<SongInfo> songs;
  const TrackBuilder({Key key, @required this.songs}) : super(key: key);

  @override
  _TrackBuilderState createState() => _TrackBuilderState();
}

class _TrackBuilderState extends State<TrackBuilder> {

AudioPlayer player = AudioPlayer();
AudioCache cached;
Duration musiclength = new Duration();
Duration position = new Duration();
@override
void initState() { 
  super.initState();
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,SystemUiOverlay.bottom]);
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
  cached.load(url);

 }

 void seekToSec(var sec){
   Duration posSec = Duration(seconds: sec);
   player.seek(posSec);
 }

 
 @override
void dispose() {
  super.dispose();
  Equalizer.release();
}
  double _progress = 0.0;
  double _value = 10.0;
  String url;
  void playPause(){
    setState(()  =>  playpause = !playpause);
  }

  Widget getAlbumArt(int value){
    if(widget.songs[value].albumArtwork == null)
      return CircleAvatar(
        radius: 25.0,
        backgroundImage: AssetImage("images/pAudio.jpeg"),
      );
      else {
        return CircleAvatar(
          radius: 25.0,
          backgroundImage: FileImage(File(widget.songs[value].albumArtwork)),
        );
    }
  }
  Widget backImage(int value){
      if(widget.songs[value].albumArtwork == null)

         return Card(
            color: Colors.transparent,
           elevation: 10,
           shadowColor: Colors.black,
           child:Container(
            padding: EdgeInsets.all(5.0),
             width: MediaQuery.of(context).size.width /1.1,
            height: MediaQuery.of(context).size.height / 1.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:DecorationImage(
                 fit: BoxFit.contain,
                image:AssetImage("images/pAudio.jpeg"),),
          )
        ),
      );

      else
           return Card(
             color: Colors.transparent,
             elevation: 18,
           shadowColor: Colors.black87,

             child:  Container(
           padding: EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width/1.1,
           height: MediaQuery.of(context).size.height / 1.8,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
             image:DecorationImage(
                fit: BoxFit.contain,
               image:FileImage(File(widget.songs[value].albumArtwork)),

             ),
           ),
         ),
      );

}

  @override
  Widget build(BuildContext context) {
     return ListView.separated(
                itemBuilder: (context,index){
                return ListTile(
                  leading:getAlbumArt(index),
                  title: Text(widget.songs[index].title,style:TextStyle(color: Colors.white)),
                  subtitle: Text(widget.songs[index].artist,style:TextStyle(color: Colors.white)),
                  onTap: (){

                   //setState(() {
                      url = widget.songs[index].filePath;

                  // });
                    // player.setNotification(
                    //   imageUrl: widget.songs[index].albumArtwork == null? "images/pAudio.jpeg":widget.songs[index].albumArtwork,
                    //   title: widget.songs[index].title,
                    //   albumTitle: widget.songs[index].album
                    // );
                    
                    player.play(widget.songs[index].filePath);
                    showCupertinoDialog(
                      // barrierDismissible: true,
                      context: context,
                     builder: (context){
                       return BottomSheet(
                         onClosing: (){},
                        builder: (context){
                          return Container(
                                padding: EdgeInsets.zero,
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:widget.songs[index].albumArtwork == null ? AssetImage("images/pAudio.jpeg"):FileImage(File(widget.songs[index].albumArtwork))),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 20,sigmaY: 20
                              ),
                              child: Column(
                              children:[
                                  // SizedBox(height: 10,),
                                  Stack(
                                    children:[
                                           backImage(index),
                                              Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child:CircleAvatar(
                                          backgroundColor: Colors.black87,

                                          child:IconButton(
                                            color: Colors.orangeAccent,
                                            onPressed: (){
                                              showCupertinoModalPopup(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 3,
                                                  sigmaY: 3
                                                ),
                                                // semanticsDismissible: true,
                                                context: context,
                                               builder: (context){
                                                 
                                                 return BottomSheet(
                                                 backgroundColor: Colors.transparent,
                                                  elevation: 20,
                                                  enableDrag: true,
                                                   onClosing: (){},
                                                   builder: (context){
                                                     return Container(
                                                       padding: EdgeInsets.all(15),
                                                       height: MediaQuery.of(context).size.height / 1.6,
                                                       decoration: BoxDecoration(
                                                          color:Colors.black45,
                                                         borderRadius: BorderRadius.only(
                                                           topLeft: Radius.circular(20),
                                                           topRight: Radius.circular(20)
                                                         )
                                                       ),
                                                       child:Column(
                                                         children: [
                                                           ListTile(
                                                             leading: Icon(
                                                               Icons.volume_down_rounded,
                                                                size:30 ,
                                                                color: Colors.orangeAccent,        
                                                             ),
                                                             title: Text("Change volume",style: TextStyle(color: Colors.orangeAccent,fontSize: 17),),
                                                             subtitle: SfSlider(
                                                               activeColor: Colors.orangeAccent,
                                                               inactiveColor: Colors.white,
                                                              //  showTicks: true,
                                                              // showLabels: true,
                                                              // stepSize: 2,
                                                              enableTooltip: true,
                                                              minorTicksPerInterval: 1,
                                                              value: _value,
                                                              min: 0.0,
                                                              interval: 20,
                                                              max: 100.0,
                                                             onChanged: (volume){
                                                               setState(() {
                                                                 _value = volume;
                                                               });
                                                           

                                                             }
                                                             ),
                                                           ),
                                                           Divider(color: Colors.orangeAccent,thickness: 0.1,),
                                                           ListTile(
                                                             leading: Icon(Icons.graphic_eq_rounded,
                                                             size: 30,
                                                             color: Colors.orangeAccent,
                                                             ),
                                                             title: Text("Equalizer",
                                                             style: TextStyle(
                                                               color: Colors.orangeAccent,
                                                             fontWeight: FontWeight.w400,
                                                             fontSize:17,
                                                             
                                                             ),
                                                             ),
                                                             onTap: (){
                                                               Navigator.pop(context);
                                                               Equalizer.open(0);
                                                             },
                                                           )
                                                            
                                                         ],
                                                       ) ,
                                                     );
                                                   },
                                                 );
                                               });
                                            },
                                            icon: Icon(Icons.settings),),
                                          )
                                      ),
                                       Positioned(
                                         bottom: 10,
                                         left: 10,
                                         child:  CircleAvatar(
                                           backgroundColor: Colors.black87,
                                           child: IconButton(
                                             color: Colors.orangeAccent,
                                             onPressed: (){
                                                
                                             },
                                             icon: Icon(Icons.shuffle_rounded),
                                             ),
                                          ),
                                    )
                                   
                                    ]
                                  ),
                                     
                                    Center(                                        
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.7),
                                            borderRadius:BorderRadius.circular(10)),
                                              child:Column(
                                            children: [
                                             Text(widget.songs[index].title,style:TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w300)),
                                             Text(widget.songs[index].artist,style:TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w300))
                                            ],
                                          ) 
                                        ),
                                      ),
                          
                                          Padding(
                                        padding: EdgeInsets.all(5),
                                        child:  Slider(
                                          activeColor: Colors.orangeAccent,
                                          inactiveColor: Colors.black87,
                                          // label: "$_value",
                                          autofocus: true,
                                           value: position.inSeconds.toDouble(),
                                           max: musiclength.inSeconds.toDouble(),
                                          min: 0,
                                         onChanged: (value){
                                            setState(() {
                                              seekToSec(value);
                                            });
                                        },
                                         ),
                                      ),
                                 Padding(
                                  padding:EdgeInsets.all(7.0),
                                  child:  Row(
                                   crossAxisAlignment:CrossAxisAlignment.center,
                                   mainAxisAlignment:MainAxisAlignment.spaceAround,
                                     children: <Widget>[
                                       CircleAvatar(
                                         backgroundColor: Colors.black87,

                                         child: IconButton(
                                           onPressed: (){
                                       },
                                        icon: Icon(Icons.fast_rewind_rounded,color: Colors.orangeAccent,),
                                        ),
                                      ),
                                      SliverVisibility(
                                       
                                      visible: playpause,
                                      sliver:CircleAvatar(
                                        radius: 30,
                                         backgroundColor: Colors.black87,
                                         child: IconButton(
                                           iconSize: 40,
                                           padding: EdgeInsets.zero,
                                          icon: Icon(
                                            
                                            Icons.play_arrow_rounded,color: Colors.orangeAccent,),
                                       onPressed: (){
                                        playpause = false;
                                       },
                                        ),
                                      ),
                                      replacementSliver:  CircleAvatar(
                                        radius:30,
                                         backgroundColor: Colors.black87,
                                         child: IconButton(
                                           padding: EdgeInsets.zero,
                                           iconSize: 40,
                                           onPressed: (){
                                            playpause = true;
                                       },
                                      icon: Icon(Icons.pause_rounded,color: Colors.orangeAccent,)
                                        ),
                                      ),
                              ),
                                    
                                  //     Visibility(
                                  //       visible: playpause,
                                  //       child: CircleAvatar(
                                  //       radius: 30,
                                  //        backgroundColor: Colors.black87,
                                  //        child: IconButton(
                                  //          iconSize: 40,
                                  //          padding: EdgeInsets.zero,
                                  //         icon: Icon(
                                            
                                  //           Icons.play_arrow_rounded,color: Colors.orangeAccent,),
                                  //      onPressed: (){
                                  //       playpause = false;
                                  //      },
                                  //       ),
                                  //     ),
                                  //     replacement:  CircleAvatar(
                                  //       radius:30,
                                  //        backgroundColor: Colors.black87,
                                  //        child: IconButton(
                                  //          padding: EdgeInsets.zero,
                                  //          iconSize: 40,
                                  //          onPressed: (){
                                  //           playpause = true;
                                  //      },
                                  //     icon: Icon(Icons.pause_rounded,color: Colors.orangeAccent,)
                                  //       ),
                                  //     ),
                                  // ),

                                      CircleAvatar(
                                        // radius:30,
                                         backgroundColor: Colors.black87,
                                         child: IconButton(
                                           onPressed: (){
                                            //  player.seekToNext();
                                       },
                                      icon: Icon(Icons.fast_forward_rounded,color: Colors.orangeAccent,),
                                        ),
                                      ),
                                     ],
                                   ),
                                ),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                        style:TextStyle(
                                          color: Colors.orangeAccent,
                                          fontFamily:"Arial",
                                          fontSize: 17
                                        )
                                        ),
                                        Text("${musiclength.inMinutes}:${musiclength.inSeconds.remainder(60)}",
                                        style:TextStyle(
                                          color: Colors.orangeAccent,
                                          fontFamily:"Arial",
                                          fontSize: 17
                                        ),
                                      )
                                      ],
                                    ),
                                  ),
                                )
                                // Text('$id3.getMetaTags()'),
                          
                              ],
                            ),
                        ),
                      );
                    
                    // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                    // floatingActionButton: FloatingActionButton.extended(
                    //   backgroundColor: Colors.orangeAccent,

                    //              onPressed: (){}, 
                    //              label:Text("EQ",style: TextStyle(color:Colors.black),),
                    //              icon: Icon(
                    //                Icons.equalizer_rounded,
                    //                color: Colors.black,),),
                  
                   });
                     });

                  },
                );
              },
              separatorBuilder: (context,item) => Divider(color: Colors.white,thickness: 0.1,),
               itemCount: widget.songs.length,
     );
  }
}

// class FloatButton extends StatefulWidget{
//  FloatingActionButtonLocation floatingActionButtonLocation;
//  FloatingActionButton floatingActionButton;

//  @override
//  Widget build(BuildContext context) {
//    return FloatButton({
//     this.floatingActionButtonLocation,
//     this.floatingActionButton

//   });
//  }
  
// }