import 'package:advance_video_share/services/api_video_list.dart';
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
    'Create Your Own Video' // 0/8
  ];
  List urlList = [];

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
    MixStatusVideo().getlist().then((List<String> _list) {
      setState(() {
        mixStatusVideoUrlList.addAll(_list);
      });
    });
    ShortMovieVideo().getlist().then((List<String> _list) {
      setState(() {
        shortMovieVideoUrlList.addAll(_list);
      });
    });
    FestiveStatus().getlist().then((List<String> _list) {
      setState(() {
        festiveStatusUrlList.addAll(_list);
      });
    });
    KidsZone().getlist().then((List<String> _list) {
      setState(() {
        kindsZoneUrlList.addAll(_list);
      });
    });
    OldSongsVideo().getlist().then((List<String> _list) {
      setState(() {
        oldSongsVideoUrlList.addAll(_list);
      });
    });
    PhotoStatus().getlist().then((List<String> _list) {
      setState(() {
        photoStatusUrlList.addAll(_list);
      });
    });
    CreateYourOwnVideo().getlist().then((List<String> _list) {
      setState(() {
        photoStatusUrlList.addAll(_list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Everyday Status, Businesscard, photo & video status'),
      ),
      drawer: homePageDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  MainCategoryTitle(
                    titleText: "Make Your Business Card Status",
                    onPressed: () {},
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: 100,
                            width: 100,
                            color: Colors.amberAccent,
                            child: Image.asset('assets/photos/09.jpg'),
                          ),
                          onTap: () {},
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MainCategoryTitle(
                titleText: 'Mix Status Video',
                onPressed: () {},
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List<Widget>.generate(mixStatusVideoUrlList.length,
                      (int index1) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 200,
                        width: 140,
                        child: VideoPlayer(
                          VideoPlayerController.network(
                              mixStatusVideoUrlList[index1])
                            ..initialize(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              MainCategoryTitle(
                  titleText: 'Short Movie Video', onPressed: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List<Widget>.generate(shortMovieVideoUrlList.length,
                      (int index1) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 200,
                        width: 140,
                        child: VideoPlayer(
                          VideoPlayerController.network(
                              shortMovieVideoUrlList[index1])
                            ..initialize(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              MainCategoryTitle(titleText: 'Festive Status', onPressed: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List<Widget>.generate(festiveStatusUrlList.length,
                      (int index1) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 200,
                        width: 140,
                        child: VideoPlayer(
                          VideoPlayerController.network(
                              festiveStatusUrlList[index1])
                            ..initialize(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              MainCategoryTitle(titleText: 'Kids Zone', onPressed: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List<Widget>.generate(kindsZoneUrlList.length,
                      (int index1) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 200,
                        width: 140,
                        child: VideoPlayer(
                          VideoPlayerController.network(
                              kindsZoneUrlList[index1])
                            ..initialize(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              MainCategoryTitle(titleText: 'Old Songs Video', onPressed: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List<Widget>.generate(oldSongsVideoUrlList.length,
                      (int index1) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 200,
                        width: 140,
                        child: VideoPlayer(
                          VideoPlayerController.network(
                              oldSongsVideoUrlList[index1])
                            ..initialize(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              MainCategoryTitle(titleText: 'Photo Status', onPressed: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List<Widget>.generate(photoStatusUrlList.length,
                      (int index1) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 200,
                        width: 140,
                        child: VideoPlayer(
                          VideoPlayerController.network(
                              photoStatusUrlList[index1])
                            ..initialize(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              MainCategoryTitle(
                  titleText: 'Create Your Own Video', onPressed: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List<Widget>.generate(createYourOwnVideoUrlList.length,
                      (int index1) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 200,
                        width: 140,
                        child: VideoPlayer(
                          VideoPlayerController.network(
                              createYourOwnVideoUrlList[index1])
                            ..initialize(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
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


// NetworkImage(
//                                       'http://alakshyatechno.tech/video/image/1.png'),

// 1/2 :- main catalofy
// http://alakshyatechno.tech/subcategorylist 
// route :- all 0 