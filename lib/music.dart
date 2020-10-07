import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MyMusicClass extends StatefulWidget {
  @override
  _MyMusicClassState createState() => _MyMusicClassState();
}

class _MyMusicClassState extends State<MyMusicClass> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool isplaying = false;
  pauseAudio() async {
    await assetsAudioPlayer.pause();
  }

  stopAudio() async {
    await assetsAudioPlayer.stop();
  }

  resumeAudio() async {
    await assetsAudioPlayer.play();
  }

  nextAudio() async {
    await assetsAudioPlayer.next();
  }

  prevAudio() async {
    await assetsAudioPlayer.previous();
  }

  playAudio(url) async {
    assetsAudioPlayer.open(
      Audio.file(url),
    );
  }

  playAudioFromLocalStorage(path) async {
    await assetsAudioPlayer.open(path);
  }

  Duration abc;
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
