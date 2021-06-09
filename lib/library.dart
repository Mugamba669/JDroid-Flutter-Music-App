import 'dart:ui';

import 'package:app/music/albums.dart';
// import 'package:app/music/genres.dart';
import 'package:app/music/playlist.dart';
import 'package:app/music/songs.dart';
import 'package:flutter/material.dart';

import 'music/artists.dart';

class Library extends StatefulWidget {
  Library({Key key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
        image: AssetImage("images/pAudio.jpeg"),fit: BoxFit.cover)
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
        child: SafeArea(
        child:ListView(
          children: [
            ListTile(
              leading: Icon(Icons.music_note_rounded,color: Colors.orangeAccent,),
              title: Text("All Songs",style:TextStyle(color: Colors.orangeAccent,)),
              onTap:(){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Songs(),fullscreenDialog: true,
                ));
              } ,
            ),
            Divider(),
             ListTile(
              leading: Icon(Icons.album_rounded,color: Colors.orangeAccent),
              title: Text("Albums",style:TextStyle(color: Colors.orangeAccent,)),
              onTap:(){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Albums(),fullscreenDialog: true,
                ));
              } ,
            ),
            Divider(),

             ListTile(
              leading: Icon(Icons.speaker_group_rounded,color: Colors.orangeAccent),
              title: Text("Artists",style:TextStyle(color: Colors.orangeAccent,)),
              onTap:(){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Artists(),fullscreenDialog: true,
                ));
              } ,
            ),
            Divider(),
            //  ListTile(
            //   leading: Icon(Icons.speaker_group_rounded,color: Colors.orangeAccent),
            //   title: Text("Genres",style:TextStyle(color: Colors.orangeAccent,)),
            //   onTap:(){
            //     Navigator.push(context, MaterialPageRoute(
            //       builder: (context) => Genres(),fullscreenDialog: true,
            //     ));
            //   } ,
            // ),
            // Divider(),
              ListTile(
              leading: Icon(Icons.playlist_play_rounded,color: Colors.orangeAccent),
              title: Text("Playlists",style:TextStyle(color: Colors.orangeAccent,)),
              onTap:(){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PlayLists(),fullscreenDialog: true,
                ));
              } ,
            ),
          ],
        ),
        )
      )
    );
  }
}