import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

class AudiNet extends StatefulWidget {
  @override
  _AudiNetState createState() => _AudiNetState();
}

class _AudiNetState extends State<AudiNet> {
  final urlText = TextEditingController();
  AudioPlayer _player = AudioPlayer();
  Duration position = Duration();
  Duration duration = Duration();
  bool isPlaying = false;
  void netAudio(String url) async {
    try {
      await _player.play(url, isLocal: true);
      _player.onAudioPositionChanged.listen((Duration time) {
        setState(() {
          position = time;
          isPlaying = true;
        });
      });
      setState(() {
        _player.onPlayerStateChanged.listen((event) {
          duration = _player.duration;
        });
      });
    } catch (t) {
      print(t);
    }
  }

  void onSubmitted() {
    String urlEnteredText = urlText.text;
    if (urlEnteredText != null && !isPlaying) {
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
            slider(),
            Center(
              child: Text(
                "${position.inSeconds.toDouble()}/${duration.inSeconds.toDouble()}",
                style: TextStyle(fontSize: 25),
              ),
            ),
            CircleAvatar(
              maxRadius: 30,
              child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  iconSize: 30,
                  onPressed: () async {
                    await _player.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget slider() {
    return Slider.adaptive(
      min: 0.0,
      value: position.inSeconds.toDouble(),
      max: duration.inSeconds.toDouble(),
      onChanged: (duration) {
        _player.seek(duration.toDouble());
      },
    );
  }
}
