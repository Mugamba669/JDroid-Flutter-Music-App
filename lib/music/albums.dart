import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class Albums extends StatefulWidget {
  @override
  _Album createState()=> _Album();
}

class _Album extends State<Albums>{
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: FlutterAudioQuery().getAlbums(),
          // ignore: missing_return
          builder: (context,AsyncSnapshot snapshot){
            List<AlbumInfo> jams = snapshot.data;
            if(snapshot.hasData)
              if(jams.length == null)
                return Center(
                  child: Container(
                    child: Text("No Albums found"),
                  ),
                );
                else
              return LoadAlbum(albums:jams);
            else
             return Padding(
                 padding: const EdgeInsets.only(top:240),
                 child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text("Loading Albums",
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
          })
      ),
    );
  }
}
class LoadAlbum extends StatefulWidget {
  final List<AlbumInfo> albums;
  const LoadAlbum({Key key,this.albums}):super(key: key);
  @override
  _LoadAlbumState createState() => _LoadAlbumState();
}

class _LoadAlbumState extends State<LoadAlbum> {
  // ignore: non_constant_identifier_names
  ImageProvider<Object> LoadAssets(int asset) {
      if(widget.albums[asset].albumArt == null)
        return AssetImage("images/pAudio.jpeg");
      else
        return FileImage(File(widget.albums[asset].albumArt));
  }
  Widget loadImages(int load){
     if(widget.albums[load].albumArt == null){
       return Image(image: AssetImage("images/pAudio.jpeg"));
     }else{
       return Image.file(File(widget.albums[load].albumArt));
     }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(itemBuilder: (context,index){
        return ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage:LoadAssets(index),
          ),
          title:Text(widget.albums[index].title,style: TextStyle(color: Colors.deepOrange),),
          subtitle:Text("Tracks (${widget.albums[index].numberOfSongs})",style: TextStyle(color: Colors.deepOrange),),
          // trailing: loadImages(index),
        );
      }, separatorBuilder:(context,data)=> Divider(), itemCount: widget.albums.length),
    );
  }
}