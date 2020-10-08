import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class AudiNet extends StatefulWidget {
  @override
  _AudiNetState createState() => _AudiNetState();
}

class _AudiNetState extends State<AudiNet> {
  final urlText = TextEditingController();
  AudioPlayer _player;
  ConcatenatingAudioSource concatenatingAudioSource;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    concatenatingAudioSource = ConcatenatingAudioSource();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
  }

  void netAudio(String url) async {
    try {
      await _player.setUrl(url);
    } catch (t) {
      print(t);
    }
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
                      onPressed: () async {
                        await _player.pause();
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
