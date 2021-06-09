import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_visualizers/Visualizers/CircularBarVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';

class Visual extends StatefulWidget {
  const Visual({Key key}) : super(key: key);

  @override
  _VisualState createState() => _VisualState();
}

class _VisualState extends State<Visual> {
  int playerID;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    JdroidCalls.playSong();
    int sessionId;
    // PlatforM Messages May fail, so we use a try/catch PlatforMException.
    try {
      sessionId = await JdroidCalls.getSessionId();
    } on Exception {
      sessionId = null;
    }

    setState(() {
      playerID = sessionId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Visualizer(
          builder: (context, data) {
            return CustomPaint(
              painter: CircularBarVisualizer(
                  waveData: data,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red),
              child: Container(),
            );
          },
          id: playerID,
        ),
      ),
    );
  }
}

class JdroidCalls {
  static const MethodChannel _channel = const MethodChannel('calls');

  static Future<int> getSessionId() async {
    int session;
    try {
      final int result = await _channel.invokeMethod('getSessionID');
      session = result;
    } on PlatformException catch (e) {
      session = null;
    }
    return session;
  }

  static playSong() async {
    _channel.invokeMethod('playSong');
  }
}
