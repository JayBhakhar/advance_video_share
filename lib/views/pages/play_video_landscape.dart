import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:advance_video_share/views/widgets/VideoItem.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:photo_view/photo_view.dart';

import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:math' as math; // import this
import 'package:whatsapp_share/whatsapp_share.dart';

class PlayVideoLandscape extends StatefulWidget {
  final String videoUrl;
  final List<String> videoUrls;
  final int position;

  PlayVideoLandscape({this.videoUrl, this.videoUrls,this.position});

  @override
  PlayVideoLandscapeState createState() => PlayVideoLandscapeState();
}

class PlayVideoLandscapeState extends State<PlayVideoLandscape> {
  String progress1 = '0';
  String downloadUrl = '0';
  String loadingTextVideo = "Downloading video....";
  String loadingTextPhoto = "Downloading photo....";
  String _sharePath = "", _localPath = "";
  ReceivePort _port = ReceivePort();
  bool isVideo = false;
  bool isLoading = true;
  bool isVideoPause = false;
  int currentIndex = 0;
  List<String> videoUrls = [];
  var childButtons = List<UnicornButton>();

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
    setState(() {
      childButtons.add(UnicornButton(
          hasLabel: true,
          labelText: "Download",
          currentButton: FloatingActionButton(
            heroTag: "download",
            backgroundColor: Colors.redAccent,
            mini: true,
            child: Icon(Icons.download_sharp),
            onPressed: () {
              _downloadFile();
            },
          )));

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

    setState(() {
      videoUrls.addAll(widget.videoUrls);
      if (widget.videoUrl.split("~")[0].endsWith("/")) {
     //   videoUrls.removeAt(widget.position);
        videoUrls.insert(0, videoUrls[widget.position]);
        isVideo = false;
        downloadUrl = videoUrls[currentIndex].split("~")[1];
        isLoading = false;
      } else {
        downloadUrl = widget.videoUrl.split("~")[0];
        isVideo = true;
      }
    });
    // if (isVideo) {
    //   _controller = VideoPlayerController.network(downloadUrl)
    //     ..initialize().then((_) {
    //       setState(() {
    //         isLoading = false;
    //         _controller.play();
    //       }); //when your thumbnail will show.
    //     });
    // }
    initPath();
    initFlutterDownloader();
    _bindBackgroundIsolate();
  }

  Future<String> checkDownloadedList(String getfileName) async {
    String getName = "";
    // String _localPath = (await DownloadsPathProvider.downloadsDirectory).path + Platform.pathSeparator + 'AdvanceVideoShare'; // temp comment
    Directory dir = Directory(_sharePath);
    String mp3Path = dir.toString();
    print(mp3Path);
    List<FileSystemEntity> _files;
    List<String> filelist = [];
    try {
      _files = dir.listSync(recursive: true, followLinks: false);
      print("size==="+_files.length.toString());
      for (FileSystemEntity entity in _files) {
        String path = entity.path;
        // filelist.add(path);
        List<String> temp = path.split("/");
        if (temp[temp.length - 1] == getfileName) {
          getName = path;
        }
      }
    } catch (ex) {}
    return getName;
  }

  Future<void> initFlutterDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await FlutterDownloader.initialize(
        debug: true, // optional: set false to disable printing logs to console
      );
    } catch (Ex) {}
    FlutterDownloader.registerCallback(downloadCallback);
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      print("Data listen ===" + progress.toString());
      if (status == DownloadTaskStatus.complete) {
        print('Call download completed');
        if (mounted) {
          setState(() {
            // Navigator.of(context).pop();
            String saveMessage = "";
            if (Platform.isIOS)
              saveMessage = "File downloaded successfully on you phone under Files -> AdvanceVideoShare folder";
            else
              saveMessage = "File downloaded successfully on your phone under Downloads folder";
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                saveMessage,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
            ));
            // _showFinishDialog(id);
          });
        }
      }
      if (progress == -1) {
        print("error ===" + data.toString());
        if (mounted) {
          setState(() {
            // Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(isVideo?loadingTextVideo:loadingTextPhoto, style: TextStyle(color: Colors.red, fontSize: 17.0, fontWeight: FontWeight.bold)),
            ));
            _showErrorDialog(id);
          });
        }
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future<void> _showFinishDialog(String taskId) async {
    String saveMessage = "";
    if (Platform.isIOS)
      saveMessage = "File downloaded successfully on you phone under Files -> AdvanceVideoShare folder";
    else
      saveMessage = "File downloaded successfully on your phone under Downloads folder";

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Downloaded Successfully', style: TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.bold)),
          content: WillPopScope(
            onWillPop: () {},
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(saveMessage),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text('OK', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            // InkWell(
            //   child: Padding(
            //     padding: EdgeInsets.all(Constant.size4),
            //     child: Text('OPEN',
            //         style: TextStyle(
            //             color: AppColors.greenButtonBorder,
            //             fontSize: FontSize.s15)),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     FlutterDownloader.open(taskId: taskId);
            //   },
            // ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(String taskId) async {
    String saveMessage = "";
    saveMessage = "Something went wrong with the download file !! Please try again after some time.";

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Downloaded Failed', style: TextStyle(color: Colors.red, fontSize: 16)),
          content: WillPopScope(
            onWillPop: () {},
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(saveMessage),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Text('OK', style: TextStyle(color: Colors.green, fontSize: 16)),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            // InkWell(
            //   child: Padding(
            //     padding: EdgeInsets.all(Constant.size4),
            //     child: Text('OPEN',
            //         style: TextStyle(
            //             color: AppColors.greenButtonBorder,
            //             fontSize: FontSize.s15)),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     FlutterDownloader.open(taskId: taskId);
            //   },
            // ),
          ],
        );
      },
    );
  }

  void initPath() async {
    final status = await Permission.storage.request();
    _sharePath = (await (getExternalStorageDirectory())).path;
    _localPath = (await DownloadsPathProvider.downloadsDirectory).path.replaceAll("Download","").replaceAll("download", "") + /*Platform.pathSeparator + */'AdvanceVideoShare'; // temp comment
    print("LOCAL path==" + _localPath);
    final savedDir = new Directory(_localPath);
    _localPath = savedDir.path.toString();
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    print('Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void _downloadFile() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // _showLoaderDialog(loadingText);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isVideo?loadingTextVideo:loadingTextPhoto, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      ));
      print("Download url==" + downloadUrl);
      final id = await FlutterDownloader.enqueue(saveInPublicStorage:false,url: downloadUrl, savedDir: _localPath, showNotification: true, openFileFromNotification: true);
    } else {
      print('No permission');
    }
  }

  // Future<Null> urlFileShare() async {
  //   final RenderBox box = context.findRenderObject();
  //   if (Platform.isAndroid) {
  //     var url = widget.videoUrl.split("~")[0];
  //     var temp = url.split("/");
  //     var filename = temp[temp.length-1];
  //     print("video url=="+url.toString());
  //     var response = await get(Uri.parse(url));
  //     final documentDirectory = (await getExternalStorageDirectory()).path + "/AdvanceVideoShare";
  //     File imgFile = File('$documentDirectory/$filename');
  //     imgFile.writeAsBytesSync(response.bodyBytes);
  //
  //     Share.shareFiles(['$documentDirectory/$filename'],
  //         subject: 'video share', // app nu name rakhi sakay
  //         text: 'Hello, check your share files!', //  playstore link with some ads words
  //         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  //   } else {
  //     Share.share('Hello, check your share files!',
  //         subject: 'URL File Share',
  //         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  //   }
  // }

  Future<void> _showLoaderDialog(String loading) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: WillPopScope(
            onWillPop: () {},
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(loading),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future downloadNShare(bool isWhatsApp) async {
    // _showLoaderDialog(loadingText);
    var temp = downloadUrl.split("/");
    var filename = temp[temp.length - 1];
    String savePath = _sharePath + Platform.pathSeparator + '$filename';
    String isAlredyExist = await checkDownloadedList(filename);
    if (isAlredyExist.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Downloading ....wait..",
          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
      ));
      print("savepath===" + savePath);
      Dio dio = Dio();
      dio.options.connectTimeout = 120 * 1000;
      try {
        Response response = await dio.get(
          downloadUrl,
          onReceiveProgress: (rcv, total) async {
            print('received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');
            setState(() {
              progress1 = ((rcv / total) * 100).toStringAsFixed(0);
            });
            if (progress1 == '100') {
              print("Finished------------------");
              //   Navigator.of(context).pop();
              shareCustomFile(isWhatsApp, savePath);
            } else if (double.parse(progress1) < 100) {}
          },
          //Received data with List<int>
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );
        print("response.headers----" + response.headers.toString());
        File file = File(savePath);
        var raf = file.openSync(mode: FileMode.write);
        // response.data is List<int> type
        raf.writeFromSync(response.data);
        await raf.close();
      } catch (e) {
        print(e);
      }
    } else {
      shareCustomFile(isWhatsApp, savePath);
    }
  }

  shareCustomFile(bool isWhatsApp, String savepath) async {
    if (isWhatsApp) {
      await WhatsappShare.shareFile(
          text: "Check this amazing Biz Card- Photo & Video Status app at google play https://play.google.com/store/apps/details?id=com.cropvideo.advance_video_share",
          filePath: [savepath],
          phone: "-");
    } else {
      final RenderBox box = context.findRenderObject() as RenderBox;
      List<String> imagePaths = [];
      imagePaths.add(savepath);
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
        floatingActionButton: UnicornDialer(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
            parentButtonBackground: Colors.redAccent,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.add),
            childButtons: childButtons),
        backgroundColor: Colors.black,
        body: isVideo
            ?

            VideoItem(downloadUrl, 0)
            :
        ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: videoUrls.length,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return VisibilityDetector(
                      key: Key(videoUrls[index]+index.toString()),
                      onVisibilityChanged: (visibilityInfo) {
                        var visiblePercentage = visibilityInfo.visibleFraction * 100;
                        if(visiblePercentage>80.0){
                          currentIndex = index;
                          downloadUrl = videoUrls[currentIndex].split("~")[1];
                          debugPrint(currentIndex.toString()+' visible');
                        }
                      },
                    child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                      child:
                      Center(
                              child:
                            //   Image.network(
                            //     widget.videoUrls[index].split("~")[1],
                            //   fit: BoxFit.fill,
                            // )
                              PhotoView(
                                initialScale: PhotoViewComputedScale.contained,
                                minScale: PhotoViewComputedScale.contained,
                                imageProvider: NetworkImage(videoUrls[index].split("~")[1]),
                              )
                      ),
                      // Text("sssss",style: TextStyle(color: Colors.white),)
                    ),
                  );
                },
              )
        // Center(
        //         child: Image.network(
        //         downloadUrl,
        //         fit: BoxFit.fill,
        //       )),

        // Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     InkWell(
        //       onTap: () {
        //         _downloadFile();
        //       },
        //       child: Icon(
        //         Icons.download_sharp,
        //         color: Colors.white,
        //         size: 40,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 16,
        //     ),
        //     InkWell(
        //       onTap: () async {
        //         // urlFileShare();
        //         downloadNShare(false);
        //       },
        //       child: Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: Icon(Icons.reply, color: Colors.white, size: 40)),
        //     ),
        //     // SizedBox(
        //     //   height: 16,
        //     // ),
        //     // InkWell(
        //     //   onTap: () {},
        //     //   child: Image.asset(
        //     //   'assets/icon/repost.png',
        //     //   width: 28,
        //     //     fit: BoxFit.fitHeight,
        //     // ),
        //     // ),
        //     SizedBox(
        //       height: 20,
        //     ),
        //     InkWell(
        //       onTap: () {
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
        // ),
      ),
    );
  }

// @override
// void dispose() {
//   super.dispose();
//   _controller.dispose();
// }
}
