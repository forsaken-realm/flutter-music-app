import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class MyMusicClass extends StatefulWidget {
  @override
  _MyMusicClassState createState() => _MyMusicClassState();
}

class _MyMusicClassState extends State<MyMusicClass> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool isplaying = false;

  Duration abc;

  void deactivate() {
    super.deactivate();
    assetsAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Asset audio",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            maxRadius: 30,
            child: IconButton(
              icon: Icon(
                isplaying ? Icons.pause : Icons.play_arrow,
              ),
              iconSize: 30,
              onPressed: () {
                if (isplaying == false) {
                  assetsAudioPlayer.open(
                    Audio("assets/audio/new.m4a"),
                    showNotification: true,
                    volume: 100,
                  );
                  abc = assetsAudioPlayer.current.value.audio.duration;
                  setState(() {
                    isplaying = true;
                  });
                } else {
                  print(abc);
                  assetsAudioPlayer.pause();
                  setState(() {
                    isplaying = false;
                  });
                }
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            child: IconButton(
              icon: Icon(
                Icons.crop_square,
                color: Colors.white,
              ),
              onPressed: () {
                assetsAudioPlayer.playOrPause();
              },
            ),
          ),
        ],
      ),
    );
  }
}
