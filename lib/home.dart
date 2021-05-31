// import 'package:app/Eq/eq.dart';
import 'package:app/library.dart';
import 'package:app/music/search.dart';
// import 'package:equalizer/equalizer.dart';
// import 'package:app/music/songs.dart';
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
  Widget currentPage;
  List pages = [];
  int _currentIndex = 0;
  @override
  void initState() { 
    super.initState();
    pages..add(Library())..add(SearchTrack());
    currentPage = pages[_currentIndex];
  }
  
  void openBar(int index){
  //  setState(() {
      _currentIndex = index;
      currentPage = pages[index];
  //  });
  }
  GlobalKey<ScaffoldState> open = GlobalKey<ScaffoldState>();
  // GlobalKey btn = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body:currentPage,
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
               leading:Icon(Icons.settings,color: Colors.orangeAccent),
               title:Text("Settings",style: TextStyle(color: Colors.orangeAccent)
              ),
              onTap: (){
                Navigator.pop(context);
              }
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: (value){
            openBar(value);
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.library_music_rounded,color: Colors.orangeAccent,),
            label: "Library",
            ),
 BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded,color: Colors.orangeAccent),
            label: "Search",
            ),

        ],
        ),
      );
  }
}