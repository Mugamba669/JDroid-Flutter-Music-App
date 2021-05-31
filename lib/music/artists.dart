import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class Artists extends StatefulWidget {
  @override
  _ArtistsState createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  var player = AudioPlayer();
  @override
  void initState() { 
    super.initState();
    print(player.androidAudioSessionId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: FlutterAudioQuery().getArtists(),
          // ignore: missing_return
          builder: (context,AsyncSnapshot snapshot){
            List<ArtistInfo> jams = snapshot.data;
            if(snapshot.hasData)
              return LoadArtist(albums:jams);
            else
              return Padding(
                 padding: const EdgeInsets.only(top:240),
                 child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text("Loading Artists",
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

class LoadArtist extends StatefulWidget {
  final List<ArtistInfo> albums;
  const LoadArtist({Key key,this.albums}):super(key: key);
  @override
  _LoadArtistState createState() => _LoadArtistState();
}

class _LoadArtistState extends State<LoadArtist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(itemBuilder: (context,index){
        return ListTile(
          title:Text(widget.albums[index].name,style: TextStyle(color: Colors.deepOrange),)
        );
      }, separatorBuilder:(context,data)=> Divider(), itemCount: widget.albums.length),
    );
  }
}