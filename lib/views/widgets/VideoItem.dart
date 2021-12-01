import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';


class VideoItem extends StatefulWidget {
  final String url;
  final int index;
  final bool isPostrate;

  VideoItem(this.url,this.index,this.isPostrate);

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool isInitVideo = false;
  bool isVideoPause = false;

  @override
  void initState() {
    super.initState();
    print("widget.url--"+widget.url);
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          isInitVideo = true;
          _controller.play();
        });
      });
    _controller.setLooping(false);
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        isInitVideo? RotatedBox(
          quarterTurns: /*widget.isPostrate?1:*/0,
          child: Center(
            child: GestureDetector(
              onTap: _playPause,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    widget.isPostrate?Align(
                        alignment: Alignment.bottomCenter,
                        child: VideoProgressIndicator(_controller, allowScrubbing: true)):Container(),
                  ],
                ),
              ),
            ),
          ),
        ):Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)),
        isVideoPause?Center(
            child: FaIcon(
              FontAwesomeIcons.solidPlayCircle,
              color: Colors.black,
              size: 56.0,
            )):Container()
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }


  _playPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        isVideoPause = true;
      });
    } else {
      _controller.play();
      setState(() {
        isVideoPause = false;
      });
    }
  }
}
