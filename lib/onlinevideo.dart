import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class OnlineVideoPage extends StatefulWidget {
  final String url;
  final YoutubePlayerController controller;
  OnlineVideoPage({this.url, this.controller});
  @override
  _OnlineVideoPageState createState() => _OnlineVideoPageState();
}

class _OnlineVideoPageState extends State<OnlineVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Online player"),
        ),
        body: Center(
          child: Container(
            child: YoutubePlayer(
              controller: widget.controller,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {},
              onEnded: (_) {
                Navigator.pop(context);
              },
            ),
          ),
        ));
  }
}
