import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_video_view/native_video_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'onlinevideo.dart';

class AssetAudio extends StatefulWidget {
  @override
  _AssetAudioState createState() => _AssetAudioState();
}

class _AssetAudioState extends State<AssetAudio> {
  final textControl = TextEditingController();

  void onSubmitted() {
    final url = textControl.text;
    if (url != null) {
      String videoId;
      videoId = YoutubePlayer.convertUrlToId(url);
      YoutubePlayerController _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OnlineVideoPage(
            url: videoId,
            controller: _controller,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Asset video player"),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.center,
          child: NativeVideoView(
            keepAspectRatio: true,
            showMediaController: true,
            onCreated: (controller) {
              controller.setVideoSource(
                'assets/video/new.mp4',
                sourceType: VideoSourceType.asset,
              );
            },
            onPrepared: (controller, info) {
              controller.play();
            },
            onError: (controller, what, extra, message) {
              print('Player Error ($what | $extra | $message)');
            },
            onCompletion: (controller) {
              print('Video completed');
            },
            onProgress: (progress, duration) {
              print('$progress | $duration');
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: textControl,
          decoration: InputDecoration(labelText: 'Enter online video url'),
          onSubmitted: (_) => onSubmitted(),
        ),
        RaisedButton(
          color: Colors.black,
          splashColor: Colors.white,
          onPressed: onSubmitted,
          child: Text(
            'Play video online',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
