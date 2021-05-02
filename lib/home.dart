import 'package:app/UI/player.dart';
import 'package:app/music/songs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  _Home createState() => _Home();
}
class _Home extends State<Home> with TickerProviderStateMixin{
  double width = 100.0;
  double height = 100.0;
  
  void increaseWidth(){
    setState(() {
      height = height >= 320.0 ? 100.0 : height += 60;
    });
    
  }
  
  GlobalKey<ScaffoldState> open = GlobalKey<ScaffoldState>(debugLabel: "Demo");
  // GlobalKey btn = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: open,
      // backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.menu,color:Colors.orangeAccent),
        onPressed: (){
          open.currentState.openDrawer();
        },),
        title: Text("Jdroid App",style: TextStyle(color: Colors.orangeAccent)),
        backgroundColor: Colors.black,
        actions: [
        
      ],),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        addAutomaticKeepAlives: true,
        children: [
          Card(
            elevation: 16.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.5),
                  color: Colors.black38,
                  image:DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage("images/default2.png"),
                    colorFilter:ColorFilter.mode(Colors.black45, BlendMode.darken),
                    fit: BoxFit.cover)
              ),
              child: TextButton.icon(
                icon: Icon(Icons.music_note_rounded,color: Colors.orangeAccent,size:30),
                
                label: Text("All Music",
                style: TextStyle(
                color:Colors.orangeAccent
              ),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  Songs()
                  ),);
              },
              ),
            ),
          ),

          Card(
            elevation: 16.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.5),
                  color: Colors.black38,
                  image:DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage("images/default2.png"),
                    colorFilter:ColorFilter.mode(Colors.black45, BlendMode.darken),
                    fit: BoxFit.cover)
              ),
              child: TextButton.icon(
                icon: Icon(Icons.album_rounded,color: Colors.orangeAccent,size: 30,),
                label: Text("Albums",
                style: TextStyle(
                color:Colors.orangeAccent
              ),
              ),
              onPressed: (){},
              ),
            ),
          ),
        Card(
            elevation: 16.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.5),
                  color: Colors.black38,
                  image:DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage("images/default2.png"),
                    colorFilter:ColorFilter.mode(Colors.black45, BlendMode.darken),
                    fit: BoxFit.cover)
              ),
              child: TextButton.icon(
                icon: Icon(Icons.playlist_play_rounded,color: Colors.orangeAccent,size: 30,),
                label: Text("PlayLists",
                style: TextStyle(
                color:Colors.orangeAccent,
                // fontSize: 18,
              ),
              ),
              onPressed: (){

              },
              ),
            ),
          ),

           Card(
            elevation: 16.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.5),
                  color: Colors.black38,
                  image:DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage("images/default2.png"),
                    colorFilter:ColorFilter.mode(Colors.black45, BlendMode.darken),
                    fit: BoxFit.cover)
              ),
              child: TextButton.icon(
                icon: Icon(Icons.speaker,color: Colors.orangeAccent,size: 30,),
                label: Text("Genres",
                style: TextStyle(
                color:Colors.orangeAccent
              ),
              ),
              onPressed: (){},
              ),
            ),
          ),

        ],
      ),
      drawer: Drawer(
        elevation: 30.0,
        child:Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.95),
           backgroundBlendMode: BlendMode.darken
          ),
          child: ListView(

            children: [
               UserAccountsDrawerHeader(
                 margin: EdgeInsets.zero,
               decoration:BoxDecoration(
                 image:DecorationImage(
                   colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                     image: AssetImage("images/default2.png"),
                     fit:BoxFit.cover
                 )
               ),
            accountName: Text("Mugamba",style: TextStyle(color: Colors.orangeAccent)),
             accountEmail: Text("brunohectre@gmail.com",style: TextStyle(color: Colors.orangeAccent))),
             Divider(color: Colors.orangeAccent,thickness: 0.46,),
             ListTile(
               leading:Icon(Icons.play_circle_fill_rounded,color: Colors.orangeAccent),
               title:Text("Player UI",style: TextStyle(color: Colors.orangeAccent)
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                builder:(context) => Player()));
              },
             ),
             Divider(color: Colors.orangeAccent,thickness: 0.46,),
             ListTile(
               leading:Icon(Icons.help_center_rounded,color: Colors.orangeAccent),
               title:Text("Contact Support",style: TextStyle(color: Colors.orangeAccent),),
             ),
            Divider(color: Colors.orangeAccent,thickness: 0.46,),
             ListTile(
               leading:Icon(Icons.feedback_rounded,color: Colors.orangeAccent),
               title:Text("FeedBack",style: TextStyle(color: Colors.orangeAccent),),
             ),
            ],
          ),
        )
      ),
      );
  }
}