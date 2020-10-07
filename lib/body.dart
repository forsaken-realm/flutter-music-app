import 'package:flutter/material.dart';
import 'package:musicapp/audionet.dart';
import 'package:musicapp/music.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> bodyItems = [
    MyMusicClass(),
    AudiNet(),
    Text("data"),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(25),
            bottomStart: Radius.circular(25),
          ),
        ),
      ),
      body: bodyItems.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: "Music",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.network_check),
            label: "Music",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            label: "Video",
          )
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
