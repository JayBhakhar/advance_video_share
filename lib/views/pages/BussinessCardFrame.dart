import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:advance_video_share/consts/AppColors.dart';
import 'package:advance_video_share/consts/Utility.dart';
import 'package:advance_video_share/models/cardModel.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '';

import 'dart:math' as math;
import 'package:whatsapp_share/whatsapp_share.dart'; // import this

class BussinessCardFrame extends StatefulWidget {
  cardModel categoryType;

  BussinessCardFrame({Key key, this.categoryType}) : super(key: key);

  @override
  _BussinessCardFrameState createState() => _BussinessCardFrameState();
}

class _BussinessCardFrameState extends State<BussinessCardFrame> {
  DateTime selectedDate = DateTime.now();
  String festivalName = "";
  String companyName = "";
  String website = "";
  String address = "";
  String contactNumber1 = "";
  String contactNumber2 = "";
  String email = "";
  String date = "";
  String baselogo = "";
  String _localPath = "", _filePath = "";
  File logoFile = null;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  Image imageFromPreferences = null;

  @override
  void initState() {
    super.initState();
    initPath();
    _initDetails();
  }

  void initPath() async {
    _localPath = (await DownloadsPathProvider.downloadsDirectory).path; // temp comment
    _filePath = (await DownloadsPathProvider.downloadsDirectory).path + Platform.pathSeparator + "BusinessCard"; // temp comment
    print("LOCAL path==" + _localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    final fileDir = Directory(_filePath);
    bool hasExisted1 = await fileDir.exists();
    if (!hasExisted1) {
      fileDir.create();
    }
  }

  _initDetails() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        festivalName = prefs.getString('festivalName');
        companyName = prefs.getString('companyName');
        website = prefs.getString('website');
        address = prefs.getString('address');
        email = prefs.getString('email');
        date = prefs.getString('date');
        contactNumber1 = prefs.getString('contactNumber1');
        contactNumber2 = prefs.getString('contactNumber2');
      });

      Utility.getImageFromPreferences().then((img) {
        if (null == img) {
          return;
        }
        setState(() {
          imageFromPreferences = Utility.imageFromBase64String(img, 78);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          'Your Business Card',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: new DecorationImage(fit: BoxFit.cover, image: new AssetImage(widget.categoryType.list)),
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Text(
                              companyName,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: TextStyle(color: Colors.white, fontSize: 19.0, fontFamily: "Source Sans Pro Light", fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(child: Container()),

                        // logoFile!=null?ClipRRect(
                        //   borderRadius: BorderRadius.circular(8.0),
                        //   child: Image.file(
                        //     logoFile,
                        //     height: 78,
                        //     width: 78,
                        //     fit: BoxFit.fill,
                        //   ),
                        // ):Container(),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Text(
                              festivalName,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: widget.categoryType.color,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'YoungSerif',
                                  letterSpacing: 0.5,
                                  height: 1.1),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                              child: imageFromPreferences != null
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ClipRRect(borderRadius: BorderRadius.circular(8.0), child: imageFromPreferences),
                                        SizedBox(
                                          width: 24.0,
                                        ),
                                      ],
                                    )
                                  : Container()),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Container(
                            // decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.topRight,
                            //     colors: [
                            //       AppColors.cardgray2,
                            //       AppColors.cardgray2,
                            //
                            //     ])
                            // ),
                            color: AppColors.cardgray.withOpacity(0.0),
                            child: Padding(
                              padding: EdgeInsets.only(top: 6.0, right: 6.0, bottom: 6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.indigoAccent,
                                        size: 10.0,
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        contactNumber1,
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontSize: 10.0,
                                            height: 1.1,
                                            fontFamily: "Source Sans Pro",
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.indigoAccent,
                                        size: 10.0,
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        contactNumber2,
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontSize: 10.0,
                                            height: 1.1,
                                            fontFamily: "Source Sans Pro",
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.mail_outline,
                                        color: Colors.indigoAccent,
                                        size: 10.0,
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        email,
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontSize: 10.0,
                                            height: 1.1,
                                            fontFamily: "Source Sans Pro",
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.internetExplorer,
                                        color: Colors.indigoAccent,
                                        size: 9.0,
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        website,
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontSize: 10.0,
                                            height: 1.1,
                                            fontFamily: "Source Sans Pro",
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            date+"",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                                height: 1.1,
                                fontFamily: "Source Sans Pro",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5),
                          ),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: widget.categoryType.color,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.0), bottomLeft: Radius.circular(8.0))),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              address,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0,
                                  height: 1,
                                  fontFamily: "Source Sans Pro",
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(
                //   child: InkWell(
                //     onTap: () async {
                //       downloadNshare();
                //     },
                //     child:
                //         Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: Icon(Icons.reply, color: Colors.white, size: 40)),
                //   ),
                // ),

                InkWell(
                  onTap: () {
                    //    _downloadFile();
                    takeScreenShot();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top:8.0,bottom: 8.0,left:8.0,right: 8.0),
                    width: 120,
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   width: cardList[index1].isSelect?6.0:0.0,
                      //   color: cardList[index1].isSelect ? Colors.red : Colors.transparent,
                      // ),
                        color: widget.categoryType.color,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Icon(
                            Icons.download_sharp,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Download",
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                height: 1,
                                fontFamily: "Source Sans Pro",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    downloadNshare();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top:8.0,bottom: 8.0,left:8.0,right: 8.0),
                    width: 120,
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   width: cardList[index1].isSelect?6.0:0.0,
                      //   color: cardList[index1].isSelect ? Colors.red : Colors.transparent,
                      // ),
                        color: widget.categoryType.color,

                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: Icon(Icons.reply, color: Colors.white, size: 16)),

                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Share",
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                height: 1,
                                fontFamily: "Source Sans Pro",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  takeScreenShot() {
    screenshotController.capture().then((Uint8List image) {
      //Capture Done
      setState(() {
        String newPath = _filePath + Io.Platform.pathSeparator + "businessCard_" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
        Future<Io.File> sucess = File(newPath).writeAsBytes(image);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Downloaded on Download/BusinessCard..Folder",
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
        ));
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  downloadNshare() {
    screenshotController.capture().then((Uint8List image) {
      //Capture Done
      setState(() {
        String newPath = _filePath + Io.Platform.pathSeparator + "businessCard_" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
        Future<Io.File> sucess = File(newPath).writeAsBytes(image);
        shareCustomFile(false, newPath);
      });
    }).catchError((onError) {
      print(onError);
    });
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
}
