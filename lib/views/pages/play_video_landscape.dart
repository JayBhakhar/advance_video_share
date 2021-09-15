import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class PlayVideoLandscape extends StatefulWidget {
  final String videoUrl;
  PlayVideoLandscape(this.videoUrl);

  @override
  _PlayVideoLandscapeState createState() => _PlayVideoLandscapeState();
}

class _PlayVideoLandscapeState extends State<PlayVideoLandscape> {
  VideoPlayerController _controller;
  int progress = 0;
  ReceivePort receivePort = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloadingvideo");

    receivePort.listen((message) {
      setState(() {
        progress = message;
      });
    });

    FlutterDownloader.registerCallback(downloadCallback);

    // _controller = VideoPlayerController.network(widget.videoUrl);
    // _controller.addListener(() {
    //   setState(() {});
    // });
    //
    // _controller.setLooping(true);
    // _controller.initialize().then((_) => setState(() {
    //   _controller.play();
    // }));

    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
            _controller.play();
        });  //when your thumbnail will show.
      });

  }

  static downloadCallback(id, status, progess) {
    SendPort sendPort = IsolateNameServer.lookupPortByName('downloadingvideo');
    sendPort.send(progess);
  }

  void _downloadFile() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String _localPath = (await DownloadsPathProvider.downloadsDirectory).path; // temp comment
      print("LOCAL path==" + _localPath);
      final savedDir = Directory(_localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
      print('+++++++++++++++++++++++++++++++++ ${_localPath}');
      final id = await FlutterDownloader.enqueue(
          url: widget.videoUrl, savedDir: _localPath,
          showNotification: true,
          openFileFromNotification: true
          );
    } else {
      print('No permission');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                _downloadFile();
              },
              child: Icon(Icons.download_sharp),
            ),
            SizedBox(
              height: 5,
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.ac_unit_outlined),
            ),
            SizedBox(
              height: 5,
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.access_alarm),
            ),
            SizedBox(
              height: 5,
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.accessible_forward_rounded),
            ),
          ],
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
