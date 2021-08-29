import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoLandscape extends StatefulWidget {
  final String videoUrl;
  PlayVideoLandscape(this.videoUrl);

  @override
  _PlayVideoLandscapeState createState() => _PlayVideoLandscapeState();
}

class _PlayVideoLandscapeState extends State<PlayVideoLandscape> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.videoUrl); 
    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: () {
            print(_controller.value.isInitialized);
            _controller.play();
          },
          child: VideoPlayer(
            _controller,
            // VideoPlayerController.network(widget.videoUrl)..initialize(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
