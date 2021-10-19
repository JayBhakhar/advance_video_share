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
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  // VideoPlayerController _controller;
  String page = "1";

  @override
  void initState() {
    super.initState();
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
        title: Text('Everyday Status, BusinessCard, photo & video status'),
      ),
      drawer: homePageDrawer(context),
      body: SafeArea(
        child: Container(
          color:  Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BussinessForm(),
                      ),
                    );
                  },
                  child: Text('Make Your Business Card Status'),
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
                      PlayVideoLandscape(videoUrl: videoUrlList[index1],videoUrls: videoUrlList),
                ),
              );
            },
          ),
        );
      }),
    ),
  );
}

// NetworkImage(
//                                       'http://alakshyatechno.tech/video/image/1.png'),

// 1/2 :- main catalofy
// http://alakshyatechno.tech/subcategorylist 
// route :- all 0 