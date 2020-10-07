import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

class AudiNet extends StatefulWidget {
  @override
  _AudiNetState createState() => _AudiNetState();
}

class _AudiNetState extends State<AudiNet> {
  String url;
  final urlText = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();

  void netAudio(String url) async {
    try {
      await audioPlayer.play(url);
    } catch (t) {}
  }

  void onSubmitted() {
    String urlEnteredText = urlText.text;
    if (urlEnteredText != null) {
      netAudio(urlEnteredText);
      urlText.clear();
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
                    onSubmitted: (_) => onSubmitted(),
                    controller: urlText,
                    decoration: InputDecoration(
                      labelText: "Enter the url",
                    ),
                  ),
                ),
                CircleAvatar(
                  maxRadius: 24,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: onSubmitted,
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
                        audioPlayer.pause();
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
