import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/services/mixStatusVideo_list.dart';
import 'package:advance_video_share/views/widgets/custom_gridviewbuilder.dart';
import 'package:flutter/material.dart';

class MixStatusVideoScreen extends StatefulWidget {
  String categoryType;

  MixStatusVideoScreen({Key key, this.categoryType}) : super(key: key);

  @override
  _MixStatusVideoScreenState createState() => _MixStatusVideoScreenState();
}

class _MixStatusVideoScreenState extends State<MixStatusVideoScreen> {
  String categoryIcon = "";
  final List<String> subcategory = [];
  final List<String> subcategoryFestive = ['all'];
  final List<String> subcategoryMix = [
    'all',
    'action',
    'bgm',
    'bike lover',
    'car lover',
    'comedy',
    'dance',
    'festival',
    'garba',
    'god',
    'horror',
    'love',
    'mother',
    'nature',
    'road trip',
    'romantic',
    'sad',
    'sport',
    'trending'
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
    'business',
    'festival',
    'friendship',
    'god',
    'love',
    'mix',
    'mother',
    'motivation',
    'navratri',
    'romantic',
    'sad',
    'shayri',
  ];

  final List<String> subcategoryShortVideo = ['all', 'action', 'bgm', 'cartoon', 'comedy', 'dance', 'horror', 'romantic', 'sad', 'trending'];

  final List<String> mixStatusVideoAll = [];
  int subcategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    getCategory();
    getCategoryVideoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF8B0000),
        title: TextField(
          onTap: () {
            showSearch(
              context: context,
              delegate: Search(subcategory),
            );
          },
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/icon/icon.png',
            width: 32,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
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
                      subcategoryIndex = index;
                      getCategoryVideoList();
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
                            child: Image.asset('$categoryIcon${subcategory[index]}.png', height: subcategoryImageHeight,fit: BoxFit.fitWidth,),
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
          Expanded(child: customGridViewBuilder(mixStatusVideoAll))
        ],
      ),
    );
  }

  void getCategoryVideoList() {
    String categoryType = "";
    if (widget.categoryType == mixStatusVideo) {
      switch (subcategoryIndex) {
        case 0:
          categoryType = categoryListAll;
          break;
        case 1:
          categoryType = actionCategory;
          break;
        case 2:
          categoryType = bgmCategory;
          break;
        case 3:
          categoryType = bikeLoverCategory;
          break;
        case 4:
          categoryType = carLoverCategory;
          break;
        case 5:
          categoryType = comedyCategory;
          break;
        case 6:
          categoryType = danceCategory;
          break;
        case 7:
          categoryType = festivalCategory;
          break;
        case 8:
          categoryType = garbaCategory;
          break;
        case 9:
          categoryType = godCategory;
          break;
        case 10:
          categoryType = horrorCategory;
          break;
        case 11:
          categoryType = loveCategory;
          break;
        case 12:
          categoryType = motherCategory;
          break;
        case 13:
          categoryType = natureCategory;
          break;
        case 14:
          categoryType = roadTripCategory;
          break;
        case 15:
          categoryType = romanticCategory;
          break;
        case 16:
          categoryType = sadCategory;
          break;
        case 17:
          categoryType = sportCategory;
          break;
        case 18:
          categoryType = trendingCategory;
          break;
      }
    } else if (widget.categoryType == kidsZoneVideo) {
      switch (subcategoryIndex) {
        case 0:
          categoryType = kidZoneMoviesAll;
          break;
        case 1:
          categoryType = kidZoneMoviesAdin;
          break;
        case 2:
          categoryType = kidZoneMoviesAnimal;
          break;
        case 3:
          categoryType = kidZoneMoviesChotabhim;
          break;
        case 4:
          categoryType = kidZoneMoviesDuckTales;
          break;
        case 5:
          categoryType = kidZoneMoviesJungleBook;
          break;
        case 6:
          categoryType = kidZoneMoviesJurassicPark;
          break;
        case 7:
          categoryType = kidZoneMoviesMotuPatlu;
          break;
        case 8:
          categoryType = kidZoneMoviesMrBean;
          break;
        case 9:
          categoryType = kidZoneMoviesTalkingTom;
          break;
        case 10:
          categoryType = kidZoneMoviesTomAndJerry;
          break;
      }
    } else if (widget.categoryType == shortMovieVideo) {
      switch (subcategoryIndex) {
        case 0:
          categoryType = shortMoviesAll;
          break;
        case 1:
          categoryType = shortMovieActionCategory;
          break;
        case 2:
          categoryType = shortMovieBgmCategory;
          break;
        case 3:
          categoryType = shortMovieCartoonCategory;
          break;
        case 4:
          categoryType = shortMovieComedyCategory;
          break;
        case 5:
          categoryType = shortMovieDanceCategory;
          break;
        case 6:
          categoryType = shortMovieHorrorCategory;
          break;
        case 7:
          categoryType = shortMovieRomanticCategory;
          break;
        case 8:
          categoryType = shortMovieSadCategory;
          break;
        case 9:
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
      switch (subcategoryIndex) {
        case 0:
          categoryType = photoStatusAll;
          break;
        case 1:
          categoryType = photoStatusBusiness;
          break;
        case 2:
          categoryType = photoStatusFestival;
          break;
        case 3:
          categoryType = photoStatusFriendship;
          break;
        case 4:
          categoryType = photoStatusGod;
          break;
        case 5:
          categoryType = photoStatusLove;
          break;
        case 6:
          categoryType = photoStatusMix;
          break;
        case 7:
          categoryType = photoStatusMother;
          break;
        case 8:
          categoryType = photoStatusMotivation;
          break;
        case 9:
          categoryType = photoStatusNavratri;
          break;
        case 10:
          categoryType = photoStatusRomantic;
          break;
        case 11:
          categoryType = photoStatusSad;
          break;
        case 12:
          categoryType = photoStatusShayri;
          break;
      }
    }

    MixStatusVideo().getSubCategoryListAll(categoryType).then((List<String> _list) {
      setState(() {
        mixStatusVideoAll.clear();
        mixStatusVideoAll.addAll(_list);
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
