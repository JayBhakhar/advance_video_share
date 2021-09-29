import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/services/mixStatusVideo_list.dart';
import 'package:advance_video_share/views/pages/BussinessForm.dart';
import 'package:advance_video_share/views/pages/MixStatusVideo_screen.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:advance_video_share/views/widgets/home_page_drawer.dart';
import 'package:advance_video_share/views/widgets/main_category_title.dart';
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

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    MixStatusVideo().getSubCategoryListAll(categoryListAll).then((List<String> _list) {
      setState(() {
        mixStatusVideoUrlList.addAll(_list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(shortMoviesAll).then((List<String> _list) {
      setState(() {
        shortMovieVideoUrlList.addAll(_list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(festiveMoviesAll).then((List<String> _list) {
      setState(() {
        festiveStatusUrlList.addAll(_list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(kidZoneMoviesAll).then((List<String> _list) {
      setState(() {
        kindsZoneUrlList.addAll(_list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(OldSongMoviesAll).then((List<String> _list) {
      setState(() {
        oldSongsVideoUrlList.addAll(_list);
      });
    });

    MixStatusVideo().getSubCategoryListAll(photoStatusAll).then((List<String> _list) {
      setState(() {
        photoStatusUrlList.addAll(_list);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Everyday Status, BusinessCard, photo & video status'),
      ),
      drawer: homePageDrawer(),
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
    _controller.dispose();
  }
}

Widget horizotalContainer(List<String> videoUrlList, BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: List<Widget>.generate(videoUrlList.length, (int index1) {
        print("Image url=="+videoUrlList[index1].split("~")[1]);
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            child: Container(
              height: 200,
              width: 140,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(videoUrlList[index1].split("~")[1])),
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0)),
              // child: VideoPlayer(
              //   VideoPlayerController.network(videoUrlList[index1])
              //     ..initialize(),
              // ), // thumbnail url
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PlayVideoLandscape(videoUrlList[index1].split("~")[0]),
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