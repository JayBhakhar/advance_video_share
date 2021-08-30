import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/services/mixStatusVideo_list.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:advance_video_share/views/widgets/custom_gridviewbuilder.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MixStatusVideoScreen extends StatefulWidget {
  @override
  _MixStatusVideoScreenState createState() => _MixStatusVideoScreenState();
}

class _MixStatusVideoScreenState extends State<MixStatusVideoScreen> {
  final List<String> subcategory = [
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

  final List<String> mixStatusVideoAll = [];
  final List<String> action = [];
  final List<String> bgm = [];
  final List<String> bikeLover = [];
  final List<String> carLover = [];
  final List<String> comedy = [];
  final List<String> dance = [];
  final List<String> festival = [];
  final List<String> garba = [];
  final List<String> god = [];
  final List<String> horror = [];
  final List<String> love = [];
  final List<String> mother = [];
  final List<String> nature = [];
  final List<String> roadTrip = [];
  final List<String> romantic = [];
  final List<String> sad = [];
  final List<String> sport = [];
  final List<String> trending = [];

  int subcategoryIndex = 0;

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    MixStatusVideo().getlistAll().then((List<String> _list) {
      setState(() {
        mixStatusVideoAll.addAll(_list);
      });
    });
    MixStatusVideo().getlistAction().then((List<String> _list) {
      setState(() {
        action.addAll(_list);
      });
    });
    MixStatusVideo().getlistBgm().then((List<String> _list) {
      setState(() {
        bgm.addAll(_list);
      });
    });
    MixStatusVideo().getlistBikeLover().then((List<String> _list) {
      setState(() {
        bikeLover.addAll(_list);
      });
    });
    MixStatusVideo().getlistCarLover().then((List<String> _list) {
      setState(() {
        carLover.addAll(_list);
      });
    });
    MixStatusVideo().getlistComedy().then((List<String> _list) {
      setState(() {
        comedy.addAll(_list);
      });
    });
    MixStatusVideo().getlistDance().then((List<String> _list) {
      setState(() {
        dance.addAll(_list);
      });
    });
    MixStatusVideo().getlistFestival().then((List<String> _list) {
      setState(() {
        festival.addAll(_list);
      });
    });
    MixStatusVideo().getlistGarba().then((List<String> _list) {
      setState(() {
        garba.addAll(_list);
      });
    });
    MixStatusVideo().getlistGod().then((List<String> _list) {
      setState(() {
        god.addAll(_list);
      });
    });
    MixStatusVideo().getlistHorror().then((List<String> _list) {
      setState(() {
        horror.addAll(_list);
      });
    });
    MixStatusVideo().getlistLove().then((List<String> _list) {
      setState(() {
        love.addAll(_list);
      });
    });
    MixStatusVideo().getlistMother().then((List<String> _list) {
      setState(() {
        mother.addAll(_list);
      });
    });
    MixStatusVideo().getlistNature().then((List<String> _list) {
      setState(() {
        nature.addAll(_list);
      });
    });
    MixStatusVideo().getlistRoadTrip().then((List<String> _list) {
      setState(() {
        roadTrip.addAll(_list);
      });
    });
    MixStatusVideo().getlistRomantic().then((List<String> _list) {
      setState(() {
        romantic.addAll(_list);
      });
    });
    MixStatusVideo().getlistSad().then((List<String> _list) {
      setState(() {
        sad.addAll(_list);
      });
    });
    MixStatusVideo().getlistSport().then((List<String> _list) {
      setState(() {
        sport.addAll(_list);
      });
    });
    MixStatusVideo().getlistTrending().then((List<String> _list) {
      setState(() {
        trending.addAll(_list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          onTap: () {
            showSearch(
              context: context,
              delegate: Search(subcategory),
            );
          },
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.search,
          color: Colors.black,
        ),
        actions: <Widget>[
          Image.asset(
            'assets/icon/icon.png',
            width: 50,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children:
                    List<Widget>.generate(subcategory.length, (int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        subcategoryIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: subcategoryConatainerHeight,
                        width: subcategoryConatainerWidth,
                        // color: Colors.amberAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                height: subcategoryImageHeight,
                                child: Image.asset(
                                    'assets/icon/mix_status_icon/${subcategory[index]}.png'),
                              ),
                            ),
                            Text(
                              subcategory[index],
                              style: subcategoryTextStyle,
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
              height: 2,
            ),
            Builder(
              builder: (BuildContext context) {
                if (subcategoryIndex == 0) {
                  return customGridViewBuilder(mixStatusVideoAll);
                } else if (subcategoryIndex == 1) {
                  return customGridViewBuilder(action);
                } else if (subcategoryIndex == 2) {
                  return customGridViewBuilder(bgm);
                } else if (subcategoryIndex == 3) {
                  return customGridViewBuilder(bikeLover);
                } else if (subcategoryIndex == 4) {
                  return customGridViewBuilder(carLover);
                } else if (subcategoryIndex == 5) {
                  return customGridViewBuilder(comedy);
                } else if (subcategoryIndex == 6) {
                  return customGridViewBuilder(dance);
                } else if (subcategoryIndex == 7) {
                  return customGridViewBuilder(festival);
                } else if (subcategoryIndex == 8) {
                  return customGridViewBuilder(garba);
                } else if (subcategoryIndex == 9) {
                  return customGridViewBuilder(god);
                } else if (subcategoryIndex == 10) {
                  return customGridViewBuilder(horror);
                } else if (subcategoryIndex == 11) {
                  return customGridViewBuilder(love);
                } else if (subcategoryIndex == 12) {
                  return customGridViewBuilder(mother);
                } else if (subcategoryIndex == 13) {
                  return customGridViewBuilder(nature);
                } else if (subcategoryIndex == 14) {
                  return customGridViewBuilder(roadTrip);
                } else if (subcategoryIndex == 15) {
                  return customGridViewBuilder(romantic);
                } else if (subcategoryIndex == 16) {
                  return customGridViewBuilder(sad);
                } else if (subcategoryIndex == 17) {
                  return customGridViewBuilder(sport);
                } else if (subcategoryIndex == 18) {
                  return customGridViewBuilder(trending);
                }
                return Container();
              },
            ),
          ],
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
