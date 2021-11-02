import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';


class VideoItem extends StatefulWidget {
  final String url;
  final int index;

  VideoItem(this.url,this.index);

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
    // return VisibilityDetector(
    //   key: Key(widget.url+widget.index.toString()),
    //   onVisibilityChanged: (visibilityInfo) {
    //     var visiblePercentage = visibilityInfo.visibleFraction * 100;
    //
    //     debugPrint(
    //         'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
    //     if(visiblePercentage > 90) {
    //            if(isInitVideo)
    //                _controller.play();
    //              // setState(() {
    //                // PlayVideoLandscapeState.currentIndex = widget.index;
    //                // PlayVideoLandscapeState.downloadUrl = widget.url;
    //                // print("Index=="+PlayVideoLandscapeState.currentIndex.toString());
    //              // });
    //     }else {
    //       if(_controller.value.initialized)
    //         if(_controller.value.isPlaying)
    //           _controller?.pause();
    //     }
    //   },
    //   child: isInitVideo? GestureDetector(
    //                 onTap: _playPause,
    //     child: AspectRatio(
    //           aspectRatio: _controller.value.aspectRatio,
    //           child: VideoPlayer(_controller),
    //         ),
    //   ):Center(child: CircularProgressIndicator(backgroundColor: Colors.white,))
    //   // child:  FutureBuilder(
    //   //   future: _initializeVideoPlayerFuture,
    //   //   builder: (context, snapshot) {
    //   //     if (snapshot.connectionState == ConnectionState.done) {
    //   //       return AspectRatio(
    //   //         aspectRatio: _controller.value.aspectRatio,
    //   //         child: VideoPlayer(_controller),
    //   //       );
    //   //     } else {
    //   //       return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
    //   //     }
    //   //   },
    //   // ),
    //   // Center(
    //   //   child: _controller.value.isInitialized
    //   //       ? AspectRatio(
    //   //         aspectRatio: _controller.value.aspectRatio,
    //   //         child: GestureDetector(
    //   //             onTap: _playPause,
    //   //             child: VideoPlayer(_controller)),
    //   //       )
    //   //       : Container(),
    //   // ),
    // );
    return Stack(
      children: [
        isInitVideo? Center(
          child: GestureDetector(
            onTap: _playPause,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
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

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print("State==="+state.toString());
  //   switch(state) {
  //     case AppLifecycleState.resumed:
  //     // Handle this case
  //      if(_controller.value.isInitialized)
  //        if(!_controller.value.isPlaying)
  //          _controller.play();
  //       break;
  //     case AppLifecycleState.inactive:
  //     // Handle this case
  //       break;
  //     case AppLifecycleState.paused:
  //       if(_controller.value.isInitialized)
  //         if(_controller.value.isPlaying)
  //           _controller.pause();
  //     // Handle this case
  //       break;
  //     case AppLifecycleState.detached:
  //       // TODO: Handle this case.
  //       break;
  //   }
  // }

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
