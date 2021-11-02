import 'dart:io';

import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/services/mixStatusVideo_list.dart';
import 'package:advance_video_share/views/pages/BussinessForm.dart';
import 'package:advance_video_share/views/pages/MixStatusVideo_screen.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:advance_video_share/views/widgets/home_page_drawer.dart';
import 'package:advance_video_share/views/widgets/main_category_title.dart';
import 'package:advance_video_share/models/listModel.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List mainCategoryList = [
    'Make Your Business Card Status',
    'Mix Status Video', // 1/2
    'Short Movie Video', // 0/3
    'Festive Status', // 0/4
    'Kids Zone', // 0/5
    'Old Songs Video', // 0/6
    'Photo Status', // 0/7
    'Create Your Own Video'
  ];

  final List<String> mixStatusVideoUrlList = [];
  final List<String> shortMovieVideoUrlList = [];
  final List<String> festiveStatusUrlList = [];
  final List<String> kindsZoneUrlList = [];
  final List<String> oldSongsVideoUrlList = [];
  final List<String> photoStatusUrlList = [];
  final List<String> createYourOwnVideoUrlList = [];
  AnimationController _controller;
  Animation<double> _animation;

  // VideoPlayerController _controller;
  String page = "1";

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1,);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInCubic,);

    _controller.forward();
    _controller.repeat(reverse:true);

    MixStatusVideo().getSubCategoryListAll(categoryListAll,page).then((ListModel _list) {
      setState(() {
        mixStatusVideoUrlList.addAll(_list.list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(shortMoviesAll,page).then((ListModel _list) {
      setState(() {
        shortMovieVideoUrlList.addAll(_list.list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(festiveMoviesAll,page).then((ListModel _list) {
      setState(() {
        festiveStatusUrlList.addAll(_list.list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(kidZoneMoviesAll,page).then((ListModel _list) {
      setState(() {
        kindsZoneUrlList.addAll(_list.list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(OldSongMoviesAll,page).then((ListModel _list) {
      setState(() {
        oldSongsVideoUrlList.addAll(_list.list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(photoStatusAll,page).then((ListModel _list) {
      setState(() {
        photoStatusUrlList.addAll(_list.list);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
        ),
        title: Text('Everyday Status, BusinessCard, photo & video status',style: TextStyle(fontSize: 16.0),),
      ),
      drawer: homePageDrawer(context),
      body: SafeArea(
        child: Container(
          color:  Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   height: 15,
                //   decoration: BoxDecoration(
                //     color: Color(0xFF8B0000),
                //     // borderRadius: BorderRadius.vertical(
                //     //     bottom: Radius.elliptical(
                //     //         MediaQuery.of(context).size.width, 400.0))
                //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(10.0))
                //   ),
                // ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BussinessForm(),
                      ),
                    );
                  },
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Image.asset(
                        "assets/photos/sss.gif",
                        width: MediaQuery.of(context).size.width,
                        height: 85.0,
                        fit: BoxFit.fill,
                      ),
                      Center(
                        child: Container(
                            height: 45,
                            margin: EdgeInsets.only(
                              top:20.0,
                              left: 32.0,
                              right: 32.0
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF8B0000),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text('Make Your Business Card Status',style: TextStyle(color: Colors.white,  fontFamily: 'YoungSerif',fontSize: 17),),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                MainCategoryTitle(
                  titleText: 'Mix Status Video',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MixStatusVideoScreen(categoryType: mixStatusVideo),
                      ),
                    );
                  },
                ),
                horizotalContainer(mixStatusVideoUrlList, context),
                MainCategoryTitle(
                    titleText: 'Short Movie Video',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MixStatusVideoScreen(categoryType: shortMovieVideo),
                        ),
                      );
                    }),
                horizotalContainer(shortMovieVideoUrlList, context),
                MainCategoryTitle(titleText: 'Festive Status',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MixStatusVideoScreen(categoryType: festiveVideo),
                        ),
                      );
                    }),
                horizotalContainer(festiveStatusUrlList, context),
                MainCategoryTitle(
                    titleText: 'Kids Zone',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MixStatusVideoScreen(categoryType: kidsZoneVideo),

                        ),
                      );
                    }),
                horizotalContainer(kindsZoneUrlList, context),
                MainCategoryTitle(titleText: 'Old Songs Video', onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MixStatusVideoScreen(categoryType: oldSongsVideo),
                    ),
                  );
                }),
                horizotalContainer(oldSongsVideoUrlList, context),
                MainCategoryTitle(
                    titleText: 'Photo Status',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MixStatusVideoScreen(categoryType: photoStatusVideo),

                        ),
                      );
                    }),
                horizotalContainer(photoStatusUrlList, context),
                TextButton(
                  onPressed: () {},
                  child: Text('Create Your Own Video'),
                )
              ],
            ),
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





Widget horizotalContainer(List<String> videoUrlList, BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: List<Widget>.generate(videoUrlList.length, (int index1) {
       // print("Image url=="+"index="+index1.toString()+"==="+videoUrlList[index1].split("~")[1]);
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            child: Container(
              height: 200,
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8.0)),
              // child: VideoPlayer(
              //   VideoPlayerController.network(videoUrlList[index1])
              //     ..initialize(),
              // ), // thumbnail url
               child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
            child: Image.network(videoUrlList[index1].split("~")[1],fit: BoxFit.fill,
              loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    // value: loadingProgress.expectedTotalBytes != null ?
                    // loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                    //     : null,
                  ),
                );
              },
            ),
          ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PlayVideoLandscape(videoUrl: videoUrlList[index1],videoUrls: videoUrlList,position: index1,),
                ),
              );
            },
          ),
        );
      }),
    ),
  );
}


class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {

    final double innerCircleRadius = 0.0;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30, rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(
        rect.width / 2 - 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 75, rect.height + 50
    );
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30, rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}

// NetworkImage(
//                                       'http://alakshyatechno.tech/video/image/1.png'),

// 1/2 :- main catalofy
// http://alakshyatechno.tech/subcategorylist 
// route :- all 0 