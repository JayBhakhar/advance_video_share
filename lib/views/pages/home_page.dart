import 'dart:io';
import 'dart:math';

import 'package:advance_video_share/consts/AdState.dart';
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
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, WidgetsBindingObserver {
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

  // AnimationController _controller;
  // Animation<double> _animation;
  String adId = "";
  String openAdId = "";
  AdState adState = null;

  // VideoPlayerController _controller;
  String page = "1";
  BannerAd banner;
  AppOpenAd appOpenAd = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    adState = Provider.of<AdState>(context,);
    adState.initialization.then((status) {
      banner = BannerAd(
        adUnitId: adId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: adState.listener,
      )..load();
    });

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _initPreference();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // _controller = AnimationController(
    //   duration: const Duration(milliseconds: 1000),
    //   vsync: this,
    //   value: 0.1,
    // );
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeInCubic,
    // );

    // _controller.forward();
    // _controller.repeat(reverse: true);

    MixStatusVideo().getSubCategoryListAll(categoryListAll, page).then((ListModel _list) {
      setState(() {
        mixStatusVideoUrlList.addAll(getRandomList(_list.list));
      });
    });

    MixStatusVideo().getSubCategoryListAll(shortMoviesAll, page).then((ListModel _list) {
      setState(() {
        shortMovieVideoUrlList.addAll(getRandomList(_list.list));
      });
    });

    MixStatusVideo().getSubCategoryListAll(festiveMoviesAll, page).then((ListModel _list) {
      setState(() {
        festiveStatusUrlList.addAll(getRandomList(_list.list));
      });
    });

    MixStatusVideo().getSubCategoryListAll(kidZoneMoviesAll, page).then((ListModel _list) {
      setState(() {
        kindsZoneUrlList.addAll(getRandomList(_list.list));
      });
    });

    MixStatusVideo().getSubCategoryListAll(OldSongMoviesAll, page).then((ListModel _list) {
      setState(() {
        oldSongsVideoUrlList.addAll(getRandomList(_list.list));
      });
    });

    MixStatusVideo().getSubCategoryListAll(photoStatusAll, page).then((ListModel _list) {
      setState(() {
        photoStatusUrlList.addAll(getRandomList(_list.list));
      });
    });
  }

  List<String> getRandomList(List<String> list) {
    final random = new Random();
    var i1 = random.nextInt(list.length - 1);
    String listModel1 = list.removeAt(i1);
    var i2 = random.nextInt(list.length - 1);
    String listModel2 = list.removeAt(i2);
    var i3 = random.nextInt(list.length - 1);
    String listModel3 = list.removeAt(i3);

    list.insert(0, listModel1);
    if (list.length > 0) list.insert(1, listModel2);
    if (list.length > 1) list.insert(2, listModel3);
    return list;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState.resumed==");
    if (state == AppLifecycleState.resumed) {

    }
  }

  _initPreference() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        adId = prefs.getString("bennerId");
        openAdId = prefs.getString("appopenad");
      });
      adState.initialization.then((status) {
        AppOpenAd.load(
            adUnitId: openAdId,
            request: AdRequest(),
            adLoadCallback: new AppOpenAdLoadCallback(onAdLoaded: (AppOpenAd ad) {
              ad.show();
            }, onAdFailedToLoad: (LoadAdError error) {
              print("onAdFailedToLoad=="+error.message.toString());
            }),
            orientation: AppOpenAd.orientationPortrait);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF8B0000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          'Biz Card- Photo & Video Status',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      drawer: homePageDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                margin: EdgeInsets.only(top: 20.0, left: 32.0, right: 32.0),
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
                                  child: Text(
                                    'Make Your Business Card Status',
                                    style: TextStyle(color: Colors.white, fontFamily: 'YoungSerif', fontSize: 17),
                                  ),
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
                    horizotalContainer(mixStatusVideoUrlList, context, mixStatusVideo),
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
                    horizotalContainer(shortMovieVideoUrlList, context, shortMovieVideo),
                    MainCategoryTitle(
                        titleText: 'Festive Status',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MixStatusVideoScreen(categoryType: festiveVideo),
                            ),
                          );
                        }),
                    horizotalContainer(festiveStatusUrlList, context, festiveVideo),
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
                    horizotalContainer(kindsZoneUrlList, context, kidsZoneVideo),
                    MainCategoryTitle(
                        titleText: 'Old Songs Video',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MixStatusVideoScreen(categoryType: oldSongsVideo),
                            ),
                          );
                        }),
                    horizotalContainer(oldSongsVideoUrlList, context, oldSongsVideo),
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
                    horizotalContainer(photoStatusUrlList, context, photoStatusVideo),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text('Create Your Own Video'),
                    // )
                  ],
                ),
              ),
            ),
            (banner != null)
                ? Container(
                    height: 55,
                    child: AdWidget(
                      // ad: banner,
                      ad: banner,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

}

Widget horizotalContainer(List<String> videoUrlList, BuildContext context, String categoryType) {
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
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8.0)),
              // child: VideoPlayer(
              //   VideoPlayerController.network(videoUrlList[index1])
              //     ..initialize(),
              // ), // thumbnail url
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  videoUrlList[index1].split("~")[1],
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
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
                  builder: (context) => PlayVideoLandscape(
                    videoUrl: videoUrlList[index1],
                    videoUrls: videoUrlList,
                    position: index1,
                    categoryType: categoryType,
                  ),
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
    path.cubicTo(rect.width / 2 - 40, rect.height + innerCircleRadius - 40, rect.width / 2 + 40, rect.height + innerCircleRadius - 40, rect.width / 2 + 75,
        rect.height + 50);
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
