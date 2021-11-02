import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/services/mixStatusVideo_list.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:flutter/material.dart';
import 'package:advance_video_share/models/listModel.dart';
import 'package:flutter/services.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class MixStatusVideoScreen extends StatefulWidget {
  String categoryType;

  MixStatusVideoScreen({Key key, this.categoryType}) : super(key: key);

  @override
  _MixStatusVideoScreenState createState() => _MixStatusVideoScreenState();
}

class _MixStatusVideoScreenState extends State<MixStatusVideoScreen> {
  String categoryIcon = "";
  final List<String> subcategory = [];
  final List<String> subcategoryFestive = [];
  int page = 1, total = 0;
  final ScrollController _scrollController = ScrollController(keepScrollOffset: false);
  final List<String> subcategoryMix = [
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

  final List<String> subcategoryKidZone = [
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

  final List<String> subcategoryPhotoStatus = [
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

  final List<String> subcategoryShortVideo = [
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

  final List<String> mixStatusVideoAll = [];
  int subcategoryIndex = 0;
  String subcategoryName = "all";

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);

    getCategory();
    getCategoryVideoList(page.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Color(0xFF8B0000),
        title: Text("Biz Card- Photo & Video Status",style: TextStyle(fontSize: 16.0),),
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
                      subcategoryName = subcategory[index];
                      subcategoryIndex = index;
                      page = 1;
                      getCategoryVideoList(page.toString());
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.0, right: 7.0),
                    child: Container(
                      // height: subcategoryConatainerHeight,
                      // width: subcategoryConatainerWidth,
                      // color: Colors.amberAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              '$categoryIcon${subcategory[index]}.png',
                              height: subcategoryImageHeight,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            subcategory[index],
                            style: subcategoryTextStyle,
                            maxLines: 2,
                          ),
                        ],
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

  // void getCategoryVideoList(String page) {
  //   String categoryType = "";
  //   if (widget.categoryType == mixStatusVideo) {
  //     switch (subcategoryIndex) {
  //       case 0:
  //         categoryType = categoryListAll;
  //         break;
  //       case 1:
  //         categoryType = actionCategory;
  //         break;
  //       case 2:
  //         categoryType = bgmCategory;
  //         break;
  //       case 3:
  //         categoryType = bikeLoverCategory;
  //         break;
  //       case 4:
  //         categoryType = carLoverCategory;
  //         break;
  //       case 5:
  //         categoryType = comedyCategory;
  //         break;
  //       case 6:
  //         categoryType = danceCategory;
  //         break;
  //       case 7:
  //         categoryType = festivalCategory;
  //         break;
  //       case 8:
  //         categoryType = garbaCategory;
  //         break;
  //       case 9:
  //         categoryType = godCategory;
  //         break;
  //       case 10:
  //         categoryType = horrorCategory;
  //         break;
  //       case 11:
  //         categoryType = loveCategory;
  //         break;
  //       case 12:
  //         categoryType = motherCategory;
  //         break;
  //       case 13:
  //         categoryType = natureCategory;
  //         break;
  //       case 14:
  //         categoryType = roadTripCategory;
  //         break;
  //       case 15:
  //         categoryType = romanticCategory;
  //         break;
  //       case 16:
  //         categoryType = sadCategory;
  //         break;
  //       case 17:
  //         categoryType = sportCategory;
  //         break;
  //       case 18:
  //         categoryType = trendingCategory;
  //         break;
  //     }
  //   } else if (widget.categoryType == kidsZoneVideo) {
  //     switch (subcategoryIndex) {
  //       case 0:
  //         categoryType = kidZoneMoviesAll;
  //         break;
  //       case 1:
  //         categoryType = kidZoneMoviesAdin;
  //         break;
  //       case 2:
  //         categoryType = kidZoneMoviesAnimal;
  //         break;
  //       case 3:
  //         categoryType = kidZoneMoviesChotabhim;
  //         break;
  //       case 4:
  //         categoryType = kidZoneMoviesDuckTales;
  //         break;
  //       case 5:
  //         categoryType = kidZoneMoviesJungleBook;
  //         break;
  //       case 6:
  //         categoryType = kidZoneMoviesJurassicPark;
  //         break;
  //       case 7:
  //         categoryType = kidZoneMoviesMotuPatlu;
  //         break;
  //       case 8:
  //         categoryType = kidZoneMoviesMrBean;
  //         break;
  //       case 9:
  //         categoryType = kidZoneMoviesTalkingTom;
  //         break;
  //       case 10:
  //         categoryType = kidZoneMoviesTomAndJerry;
  //         break;
  //     }
  //   } else if (widget.categoryType == shortMovieVideo) {
  //     switch (subcategoryIndex) {
  //       case 0:
  //         categoryType = shortMoviesAll;
  //         break;
  //       case 1:
  //         categoryType = shortMovieActionCategory;
  //         break;
  //       case 2:
  //         categoryType = shortMovieBgmCategory;
  //         break;
  //       case 3:
  //         categoryType = shortMovieCartoonCategory;
  //         break;
  //       case 4:
  //         categoryType = shortMovieComedyCategory;
  //         break;
  //       case 5:
  //         categoryType = shortMovieDanceCategory;
  //         break;
  //       case 6:
  //         categoryType = shortMovieHorrorCategory;
  //         break;
  //       case 7:
  //         categoryType = shortMovieRomanticCategory;
  //         break;
  //       case 8:
  //         categoryType = shortMovieSadCategory;
  //         break;
  //       case 9:
  //         categoryType = shortMovieTrendingCategory;
  //         break;
  //     }
  //   } else if (widget.categoryType == festiveVideo) {
  //     switch (subcategoryIndex) {
  //       case 0:
  //         categoryType = festiveMoviesAll;
  //         break;
  //     }
  //   } else if (widget.categoryType == oldSongsVideo) {
  //     switch (subcategoryIndex) {
  //       case 0:
  //         categoryType = OldSongMoviesAll;
  //         break;
  //     }
  //   } else if (widget.categoryType == photoStatusVideo) {
  //     switch (subcategoryIndex) {
  //       case 0:
  //         categoryType = photoStatusAll;
  //         break;
  //       case 1:
  //         categoryType = photoStatusBusiness;
  //         break;
  //       case 2:
  //         categoryType = photoStatusFestival;
  //         break;
  //       case 3:
  //         categoryType = photoStatusFriendship;
  //         break;
  //       case 4:
  //         categoryType = photoStatusGod;
  //         break;
  //       case 5:
  //         categoryType = photoStatusLove;
  //         break;
  //       case 6:
  //         categoryType = photoStatusMix;
  //         break;
  //       case 7:
  //         categoryType = photoStatusMother;
  //         break;
  //       case 8:
  //         categoryType = photoStatusMotivation;
  //         break;
  //       case 9:
  //         categoryType = photoStatusNavratri;
  //         break;
  //       case 10:
  //         categoryType = photoStatusRomantic;
  //         break;
  //       case 11:
  //         categoryType = photoStatusSad;
  //         break;
  //       case 12:
  //         categoryType = photoStatusShayri;
  //         break;
  //     }
  //   }
  //
  //   MixStatusVideo().getSubCategoryListAll(categoryType, page).then((ListModel _list) {
  //     setState(() {
  //       if (page == "1"){
  //         _scrollController.jumpTo(0.0);
  //         mixStatusVideoAll.clear();
  //       }
  //       mixStatusVideoAll.addAll(_list.list);
  //       total = _list.total;
  //     });
  //   });
  // }

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
        mixStatusVideoAll.addAll(_list.list);
        if(page == ""){
          _scrollController.jumpTo(0.0);
        }
        total = _list.total;
      });
    });
  }

  void getCategory() {
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
        child: widget.categoryType == shortMovieVideo?ListView.builder(
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
                          videoUrl: mixStatusVideoAll[index],
                          videoUrls: mixStatusVideoAll,
                          position: index,
                        ),
                      ),
                    );
                  },
                ),
              );
            }):GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            children: List.generate(mixStatusVideoAll.length, (index) {
              return Padding(
                padding:  EdgeInsets.all(4.0),
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
