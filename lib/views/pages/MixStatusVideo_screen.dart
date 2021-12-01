import 'dart:async';
import 'dart:math';

import 'package:advance_video_share/consts/AdState.dart';
import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/models/cardModel.dart';
import 'package:advance_video_share/models/categoryModel.dart';
import 'package:advance_video_share/services/mixStatusVideo_list.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:flutter/material.dart';
import 'package:advance_video_share/models/listModel.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MixStatusVideoScreen extends StatefulWidget {
  String categoryType;

  MixStatusVideoScreen({Key key, this.categoryType}) : super(key: key);

  @override
  _MixStatusVideoScreenState createState() => _MixStatusVideoScreenState();
}

class _MixStatusVideoScreenState extends State<MixStatusVideoScreen> {
  String categoryIcon = "";
  final List<categoryModel> subcategory0 = [];
  final List<String> subcategoryFestive0 = [];
  int page = 1, total = 0;
  final ScrollController _scrollController = ScrollController(keepScrollOffset: false);
  String insterAd = "";

  final List<String> subcategoryMix0 = [
    'all',
    'god',
    'trending',
    'love',
    'romantic',
    'festival',
    'mother',
    'nature',
    'sad',
    'bike lover',
    'car lover',
    'garba',
    'comedy',
    'dance',
    'road trip',
    'action',
    'bgm',
    'sport',
    'horror',
  ];

  final List<String> subcategoryKidZone0 = [
    'all', // 0/5
    'alladin', //6
    'animal', //5
    'chotta bhim', //1/5
    'duck tales', //7
    'jungle book', //8
    'jurassic park', //10
    'motu patlu', //2/5
    'mr bean', //4
    'talking tom', //9
    'tom and jerry', //3
  ];

  final List<String> subcategoryPhotoStatus0 = [
    'all',
    'god',
    'love',
    'mother',
    'friendship',
    'mix',
    'romantic',
    'sad',
    'motivation',
    'festival',
    'navratri',
    'shayri',
    'business',
  ];

  final List<String> subcategoryShortVideo0 = [
    'all',
    'action',
    'romantic',
    'trending',
    'sad',
    'comedy',
    'dance',
    'cartoon',
    'horror',
    'bgm',
  ];

  final List<categoryModel> subcategoryMix = [];
  final List<categoryModel> subcategory = [];
  final List<categoryModel> subcategoryPhotoStatus = [];
  final List<categoryModel> subcategoryShortVideo = [];
  final List<categoryModel> subcategoryKidZone = [];
  final List<categoryModel> subcategoryFestive = [];

  final List<String> mixStatusVideoAll = [];
  int subcategoryIndex = 0;
  String subcategoryName = "all";
  // TODO: Add _interstitialAd
  InterstitialAd _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  Timer _timerForInter; // <- Put this line on top of _MyAppState class

  @override
  void initState() {
    super.initState();
    _initPreference();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    getCategory();
    getCategoryVideoList(page.toString());

  }

  _initPreference() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        insterAd = prefs.getString("instId");
      });
      _loadInterstitialAd();
      // _timerForInter = Timer.periodic(Duration(seconds: 45), (result) {
      //
      // });
    }
  }

  setCategotyList() {
    setState(() {
      for (int i1 = 0; i1 < subcategoryMix0.length; i1++) {
        subcategoryMix.add(new categoryModel(subcategoryMix0[i1], i1 == 0 ? true : false));
      }
      for (int i1 = 0; i1 < subcategoryPhotoStatus0.length; i1++) {
        subcategoryPhotoStatus.add(new categoryModel(subcategoryPhotoStatus0[i1], i1 == 0 ? true : false));
      }
      for (int i1 = 0; i1 < subcategoryShortVideo0.length; i1++) {
        subcategoryShortVideo.add(new categoryModel(subcategoryShortVideo0[i1], i1 == 0 ? true : false));
      }
      for (int i1 = 0; i1 < subcategoryKidZone0.length; i1++) {
        subcategoryKidZone.add(new categoryModel(subcategoryKidZone0[i1], i1 == 0 ? true : false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Color(0xFF8B0000),
        title: Text(
          "Biz Card - Photo & Video Status",
          style: TextStyle(fontSize: 16.0),
        ),
        // TextField(
        //   onTap: () {
        //     showSearch(
        //       context: context,
        //       delegate: Search(subcategory),
        //     );
        //   },
        //   decoration: InputDecoration(
        //     hintText: 'Search',
        //     hintStyle: TextStyle(
        //       color: Colors.white,
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //     ),
        //     border: InputBorder.none,
        //     contentPadding: EdgeInsets.symmetric(vertical: 5.0),
        //   ),
        // ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/icon/icon.png',
            width: 32,
          ),
        ),
        // actions: <Widget>[
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(
        //       Icons.search,
        //       color: Colors.white,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: List<Widget>.generate(subcategory.length, (int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      subcategoryName = subcategory[index].name;
                      subcategoryIndex = index;
                      page = 1;
                      for (int i = 0; i < subcategory.length; i++) {
                        if (i == index)
                          subcategory[i].isSelect = true;
                        else
                          subcategory[i].isSelect = false;
                      }
                      getCategoryVideoList(page.toString());
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.0, right: 7.0),
                    child: Container(
                      // height: subcategoryConatainerHeight,
                      // width: subcategoryConatainerWidth,
                      // color: Colors.amberAccent,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        color: subcategory[index].isSelect ? Colors.white24 : Colors.transparent,
                        border: Border.all(
                          width: subcategory[index].isSelect ? 1.2 : 0.0,
                          color: subcategory[index].isSelect ? Colors.white : Colors.transparent,
                        ),
                      ),
                      child: Padding(
                        padding: subcategory[index].isSelect
                            ? EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0, bottom: 4.0)
                            : EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                '$categoryIcon${subcategory[index].name}.png',
                                height: subcategoryImageHeight,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              subcategory[index].name,
                              style: subcategoryTextStyle,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          customGridViewBuilder()
        ],
      ),
    );
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: insterAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _isInterstitialAdReady = false;
            },
          );
          _isInterstitialAdReady = true;
          _interstitialAd?.show();
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  void getCategoryVideoList(String page) {
    String categoryType = "";
    if (widget.categoryType == mixStatusVideo) {
      switch (subcategoryName) {
        case 'all':
          categoryType = categoryListAll;
          break;
        case 'action':
          categoryType = actionCategory;
          break;
        case 'bgm':
          categoryType = bgmCategory;
          break;
        case 'bike lover':
          categoryType = bikeLoverCategory;
          break;
        case 'car lover':
          categoryType = carLoverCategory;
          break;
        case 'comedy':
          categoryType = comedyCategory;
          break;
        case 'dance':
          categoryType = danceCategory;
          break;
        case 'festival':
          categoryType = festivalCategory;
          break;
        case 'garba':
          categoryType = garbaCategory;
          break;
        case 'god':
          categoryType = godCategory;
          break;
        case 'horror':
          categoryType = horrorCategory;
          break;
        case 'love':
          categoryType = loveCategory;
          break;
        case 'mother':
          categoryType = motherCategory;
          break;
        case 'nature':
          categoryType = natureCategory;
          break;
        case 'road trip':
          categoryType = roadTripCategory;
          break;
        case 'romantic':
          categoryType = romanticCategory;
          break;
        case 'sad':
          categoryType = sadCategory;
          break;
        case 'sport':
          categoryType = sportCategory;
          break;
        case 'trending':
          categoryType = trendingCategory;
          break;
      }
    } else if (widget.categoryType == kidsZoneVideo) {
      switch (subcategoryName) {
        case 'all':
          categoryType = kidZoneMoviesAll;
          break;
        case 'alladin':
          categoryType = kidZoneMoviesAdin;
          break;
        case 'animal':
          categoryType = kidZoneMoviesAnimal;
          break;
        case 'chotta bhim':
          categoryType = kidZoneMoviesChotabhim;
          break;
        case 'duck tales':
          categoryType = kidZoneMoviesDuckTales;
          break;
        case 'jungle book':
          categoryType = kidZoneMoviesJungleBook;
          break;
        case 'jurassic park':
          categoryType = kidZoneMoviesJurassicPark;
          break;
        case 'motu patlu':
          categoryType = kidZoneMoviesMotuPatlu;
          break;
        case 'mr bean':
          categoryType = kidZoneMoviesMrBean;
          break;
        case 'talking tom':
          categoryType = kidZoneMoviesTalkingTom;
          break;
        case 'tom and jerry':
          categoryType = kidZoneMoviesTomAndJerry;
          break;
      }
    } else if (widget.categoryType == shortMovieVideo) {
      switch (subcategoryName) {
        case 'all':
          categoryType = shortMoviesAll;
          break;
        case 'action':
          categoryType = shortMovieActionCategory;
          break;
        case 'bgm':
          categoryType = shortMovieBgmCategory;
          break;
        case 'cartoon':
          categoryType = shortMovieCartoonCategory;
          break;
        case 'comedy':
          categoryType = shortMovieComedyCategory;
          break;
        case 'dance':
          categoryType = shortMovieDanceCategory;
          break;
        case 'horror':
          categoryType = shortMovieHorrorCategory;
          break;
        case 'romantic':
          categoryType = shortMovieRomanticCategory;
          break;
        case 'sad':
          categoryType = shortMovieSadCategory;
          break;
        case 'trending':
          categoryType = shortMovieTrendingCategory;
          break;
      }
    } else if (widget.categoryType == festiveVideo) {
      switch (subcategoryIndex) {
        case 0:
          categoryType = festiveMoviesAll;
          break;
      }
    } else if (widget.categoryType == oldSongsVideo) {
      switch (subcategoryIndex) {
        case 0:
          categoryType = OldSongMoviesAll;
          break;
      }
    } else if (widget.categoryType == photoStatusVideo) {
      switch (subcategoryName) {
        case 'all':
          categoryType = photoStatusAll;
          break;
        case 'business':
          categoryType = photoStatusBusiness;
          break;
        case 'festival':
          categoryType = photoStatusFestival;
          break;
        case 'friendship':
          categoryType = photoStatusFriendship;
          break;
        case 'god':
          categoryType = photoStatusGod;
          break;
        case 'love':
          categoryType = photoStatusLove;
          break;
        case 'mix':
          categoryType = photoStatusMix;
          break;
        case 'mother':
          categoryType = photoStatusMother;
          break;
        case 'motivation':
          categoryType = photoStatusMotivation;
          break;
        case 'navratri':
          categoryType = photoStatusNavratri;
          break;
        case 'romantic':
          categoryType = photoStatusRomantic;
          break;
        case 'sad':
          categoryType = photoStatusSad;
          break;
        case 'shayri':
          categoryType = photoStatusShayri;
          break;
      }
    }

    MixStatusVideo().getSubCategoryListAll(categoryType, page).then((ListModel _list) {
      setState(() {
        if (page == "1") {
          mixStatusVideoAll.clear();
        }
        mixStatusVideoAll.addAll(getRandomList(_list.list));
        if (page == "") {
          _scrollController.jumpTo(0.0);
        }
        total = _list.total;
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

  void getCategory() {
    setCategotyList();
    subcategory.clear();
    switch (widget.categoryType) {
      case mixStatusVideo:
        setState(() {
          categoryIcon = "assets/icon/mix_status_icon/";
          subcategory.addAll(subcategoryMix);
        });
        break;
      case kidsZoneVideo:
        setState(() {
          categoryIcon = "assets/icon/kids_zone/";
          subcategory.addAll(subcategoryKidZone);
        });
        break;
      case shortMovieVideo:
        setState(() {
          categoryIcon = "assets/icon/short_movie/";
          subcategory.addAll(subcategoryShortVideo);
        });
        break;
      case festiveVideo:
        setState(() {
          categoryIcon = "assets/icon/mix_status_icon/";
          subcategory.addAll(subcategoryFestive);
        });
        break;
      case oldSongsVideo:
        setState(() {
          categoryIcon = "assets/icon/mix_status_icon/";
          subcategory.addAll(subcategoryFestive);
        });
        break;
      case photoStatusVideo:
        setState(() {
          categoryIcon = "assets/icon/photo_status/";
          subcategory.addAll(subcategoryPhotoStatus);
        });
        break;
    }
  }

  Widget customGridViewBuilder() {
    return Expanded(
      child: LazyLoadScrollView(
        // isLoading: true,
        // scrollOffset: 100,
        onEndOfPage: () {
          print("onEndOfPage  total=" + total.toString());
          mixStatusVideoAll.length < total ? getCategoryVideoList((page = page + 1).toString()) : () {};
        },
        child: widget.categoryType == shortMovieVideo
            ? ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: mixStatusVideoAll.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            // image: new DecorationImage(fit: BoxFit.cover, image: new NetworkImage(mixStatusVideoAll[index].split("~")[1])),
                            // image: new DecorationImage(fit: BoxFit.cover, image: new NetworkImage(mixStatusVideoAll[index].split("~")[1])),
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            mixStatusVideoAll[index].split("~")[1],
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
                                videoUrl: mixStatusVideoAll[index], videoUrls: mixStatusVideoAll, position: index, categoryType: widget.categoryType),
                          ),
                        );
                      },
                    ),
                  );
                })
            : GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                children: List.generate(mixStatusVideoAll.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(4.0),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              // image: new DecorationImage(fit: BoxFit.cover, image: new NetworkImage(mixStatusVideoAll[index].split("~")[1])),
                              // image: new DecorationImage(fit: BoxFit.cover, image: new NetworkImage(mixStatusVideoAll[index].split("~")[1])),
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              mixStatusVideoAll[index].split("~")[1],
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
                                videoUrl: mixStatusVideoAll[index],
                                videoUrls: mixStatusVideoAll,
                                position: index,
                                categoryType: widget.categoryType,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                }),
              ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "".toLowerCase();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  // here need to rebuild
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult.toLowerCase()),
      ),
    );
  }

  final List<String> listExample;

  Search(this.listExample);

  List<String> recentList = ['Action', 'Comedy', 'Garba', 'Nature', 'Sport'];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query.toLowerCase()),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
