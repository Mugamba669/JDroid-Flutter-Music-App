import 'dart:io';

import 'package:app/UI/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SearchTrack extends StatefulWidget {
  // List<SongInfo> trackList;
  SearchTrack({Key key}) : super(key: key);

  @override
  _SearchTrackState createState() => _SearchTrackState();
}

class _SearchTrackState extends State<SearchTrack> {
   final fieldController = TextEditingController();

    void dispose() {
    fieldController.dispose();
    super.dispose();
  }

  var results = "Track";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            fieldController.clear();
          },
           icon:Icon(Icons.clear,color:Colors.orangeAccent))
        ],
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.orangeAccent,),
          onPressed: (){
            Navigator.pop(context);
          },
          ),
        title:CupertinoTextField(
          controller: fieldController,
          placeholder: "Enter name of the track",
          padding: EdgeInsets.all(10),
          keyboardType: TextInputType.text,
          autocorrect: true,
          autofocus: true,
          onChanged: (value){
              setState(() {
                  results = fieldController.text;
              });
          },
          onEditingComplete: (){

          },
          )
      ),
      body: FutureBuilder(
        future: FlutterAudioQuery().searchSongs(query:results ),
        builder: (context,snapshot){
              List<SongInfo> search = snapshot.data;                
                    if(snapshot.hasData)
                        return SearchResults(result: search);
                    else
                        return Padding(
                          padding: const EdgeInsets.only(top:240),
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text("$results Not found",
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
      );
  }
}

class SearchResults extends StatefulWidget {
  final List <SongInfo>result;
  SearchResults({Key key,@required this.result}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
   Widget getAlbumArt(int value){
    if(widget.result[value].albumArtwork == null)
      return Image(
        image: AssetImage("images/default.png"),
        fit: BoxFit.contain,
      );
      else
      return Image(
          image :FileImage(File(widget.result[value].albumArtwork),),
          fit: BoxFit.contain,
        );
  }
  @override
  Widget build(BuildContext context) {        
            return ListView.separated(itemBuilder: (context,index){
                  return ListTile(
                      leading: getAlbumArt(index),
                      title: Text(widget.result[index].title),
                      subtitle: Text(widget.result[index].artist),
                      onTap: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => Portrait()));
                      },
                  );
            },
             separatorBuilder: (context,item) => Divider(), 
             itemCount:widget.result.length,
        );
  }
}