import 'package:app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   // Replace the 3 second delay with your initialization code:
    //   future: Future.delayed(Duration(seconds: 3)),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     // Show splash screen while waiting for app resources to load:
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         home: Splash(),
    //       );
    //     } else {
    //       // Loading is done, return the app:
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         home: Home(),
    //       );
    //     }
    //   },
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
