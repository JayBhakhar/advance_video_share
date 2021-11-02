import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:advance_video_share/views/widgets/VideoItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:unicorndial/unicorndial.dart';
import 'dart:math' as math;

import 'package:whatsapp_share/whatsapp_share.dart'; // import this

class PlayVideoLandscape2 extends StatefulWidget {
  final String videoUrl;
  final List<String> videoUrls;

  PlayVideoLandscape2({this.videoUrl, this.videoUrls});

  @override
  PlayVideoLandscape2State createState() => PlayVideoLandscape2State();
}

class PlayVideoLandscape2State extends State<PlayVideoLandscape2> {

  String progress1 = '0';
  String downloadUrl = '0';
  String loadingText = "Downloading video....Please wait";
  bool isVideo = false;
  bool isLoading = true;
  static int currentIndex = 0;
  var childButtons = List<UnicornButton>();


  @override
  void initState() {
    super.initState();
    print("widget.videoUrl=="+widget.videoUrl);

    setState(() {
      downloadUrl = widget.videoUrl;
      if (!widget.videoUrl.endsWith("mp4")) {
        isVideo = false;
        isLoading = false;
      } else {
        isVideo = true;
        isLoading = false;
      }


      childButtons.add(UnicornButton(
          hasLabel: true,
          labelText: "Share",
          currentButton: FloatingActionButton(
              onPressed: () {
                downloadNShare(false);
              },
              heroTag: "share",
              backgroundColor: Colors.redAccent,
              mini: true,
              child: Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: Icon(Icons.reply, color: Colors.white, size: 24)))));

      childButtons.add(UnicornButton(
          hasLabel: true,
          labelText: "Share to Whatsapp",
          currentButton: FloatingActionButton(
            onPressed: () {
              downloadNShare(true);
            },
            heroTag: "wshare",
            backgroundColor: Colors.redAccent,
            mini: true,
            child: Image.asset(
              'assets/icon/whatsapp.png',
              width: 24,
              fit: BoxFit.fitHeight,
            ),
          )));
    });
  }

  Future downloadNShare(bool isWhatsApp) async {

    if (isWhatsApp) {
      await WhatsappShare.shareFile(
          text: "Check this amazing Biz Card- Photo & Video Status app at google play https://play.google.com/store/apps/details?id=com.cropvideo.advance_video_share",
          filePath: [downloadUrl],
          phone: "-"
      );
    } else {
      final RenderBox box = context.findRenderObject() as RenderBox;
      List<String> imagePaths = [];
      imagePaths.add(downloadUrl);
      Share.shareFiles(imagePaths,
          text: "Check this amazing Biz Card- Photo & Video Status app at google play " +
              "https://play.google.com/store/apps/details?id=com.cropvideo.advance_video_share",
          subject: 'Share video',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size)
          .whenComplete(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: isVideo?
        // ListView.builder(
        //         scrollDirection: Axis.vertical,
        //         shrinkWrap: true,
        //         itemCount: widget.videoUrls.length,
        //         physics: ScrollPhysics(),
        //         itemBuilder: (context, index) {
        //           return Container(
        //           height: MediaQuery.of(context).size.height,
        //           width: MediaQuery.of(context).size.width,
        //             child: Stack(
        //               fit: StackFit.expand,
        //               children: [
        //
        //               ],
        //             ),
        //             // Text("sssss",style: TextStyle(color: Colors.white),)
        //           );
        //         },
        //       )
        VideoItem(downloadUrl,0) : Center(
                child: Image.file(
                File(downloadUrl),
                fit: BoxFit.fill,
              )),
        floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
        parentButtonBackground: Colors.redAccent,
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
        childButtons: childButtons),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     InkWell(
        //       onTap: () async {
        //         // urlFileShare();
        //         downloadNShare(false);
        //       },
        //       child: Transform(
        //           alignment: Alignment.center,
        //           transform: Matrix4.rotationY(math.pi),
        //           child: Icon(Icons.reply,color: Colors.white,size: 40)),
        //     ),
        //     SizedBox(
        //       height: 20,
        //     ),
        //     InkWell(
        //       onTap: () async {
        //         // urlFileShare();
        //         downloadNShare(true);
        //       },
        //       child: Image.asset(
        //         'assets/icon/whatsapp.png',
        //         width: 32,
        //         fit: BoxFit.fitHeight,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 24,
        //     ),
        //   ],
        // )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
