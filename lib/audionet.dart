import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudiNet extends StatefulWidget {
  @override
  _AudiNetState createState() => _AudiNetState();
}

class _AudiNetState extends State<AudiNet> {
  String url;
  TextEditingController urltext = TextEditingController();
  void onsubmitted() {
    String urlenteredtext = urltext.text;
    if (urlenteredtext != null) {
      netaudio(urlenteredtext);

      urltext.clear();
    }
  }

  final assetsAudioPlayer = AssetsAudioPlayer();

  netaudio(String url) async {
    try {
      await assetsAudioPlayer.open(
        Audio.network(
            "https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand60.wav"),
      );
    } catch (t) {
      //mp3 unreachable
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.83,
                  child: TextField(
                    onSubmitted: (_) => onsubmitted(),
                    controller: urltext,
                    decoration: InputDecoration(
                      labelText: "Enter the url",
                    ),
                  ),
                ),
                CircleAvatar(
                  maxRadius: 24,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: onsubmitted,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 30,
                  child: IconButton(
                      icon: Icon(
                        Icons.play_arrow,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        assetsAudioPlayer.playOrPause();
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
