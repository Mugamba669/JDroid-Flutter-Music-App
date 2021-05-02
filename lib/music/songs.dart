import 'dart:io';

import 'package:app/UI/player.dart';
import 'package:app/music/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class Songs extends StatefulWidget {
  Songs({Key key}) : super(key: key);

  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("All Songs",style:TextStyle(color:Colors.orangeAccent )),
      ),
      body: SafeArea(
        child:Container(
          child:FutureBuilder(
            future: FlutterAudioQuery().getSongs(),
            builder:(context,snapshot){
              List<SongInfo>tracks = snapshot.data;
              
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
              ),
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
          child: Icon(Icons.search_rounded,color:Colors.orangeAccent),
          backgroundColor: Colors.black,
      ),
    );
  }
}

class TrackBuilder extends StatefulWidget {
 final List songs;
  const TrackBuilder({Key key, @required this.songs}) : super(key: key);

  @override
  _TrackBuilderState createState() => _TrackBuilderState();
}

class _TrackBuilderState extends State<TrackBuilder> {
  Widget getAlbumArt(int value){
    if(widget.songs[value].albumArtwork == null)
      return Image(
        image: AssetImage("images/default.png"),
        fit: BoxFit.contain,
      );
      else
        Image.file(File(widget.songs[value].albumArtwork),
        fit:BoxFit.contain,
        );
  }
  @override
  Widget build(BuildContext context) {
     return ListView.separated(
                itemBuilder: (context,index){
                return ListTile(
                  leading:getAlbumArt(index),
                  title: Text(widget.songs[index].title),
                  subtitle: Text(widget.songs[index].artist),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Portrait(index: index,),
                      fullscreenDialog: true,
                    ));
                  },
                );
              }, 
              separatorBuilder: (context,item) => Divider(),
               itemCount: widget.songs.length,
     );
  }
}

// class ImageBuilder extends StatefulWidget {
//   ImageBuilder({Key key}) : super(key: key);

//   @override
//   _ImageBuilderState createState() => _ImageBuilderState();
// }

// class _ImageBuilderState extends State<ImageBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }