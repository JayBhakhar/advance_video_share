import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/services/shortMovieVideo_list.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:advance_video_share/views/widgets/custom_gridviewbuilder.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortMovieVideoScreen extends StatefulWidget {
  @override
  _ShortMovieVideoScreenState createState() => _ShortMovieVideoScreenState();
}

class _ShortMovieVideoScreenState extends State<ShortMovieVideoScreen> {
  final List<String> subcategory = [
    'all',
    'action',
    'bgm',
    'cartoon',
    'comedy',
    'dance',
    'horror',
    'romantic',
    'sad',
    'trending'
  ];

  final List<String> shortMovieVideoAll = [];
  final List<String> action = [];
  final List<String> bgm = [];
  final List<String> cartoon = [];
  final List<String> comedy = [];
  final List<String> dance = [];
  final List<String> horror = [];
  final List<String> romantic = [];
  final List<String> sad = [];
  final List<String> trending = [];

  int subcategoryIndex = 0;

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    ShortMovieVideo().getlistAll().then((List<String> _list) {
      setState(() {
        shortMovieVideoAll.addAll(_list);
      });
    });
    ShortMovieVideo().getlistAction().then((List<String> _list) {
      setState(() {
        action.addAll(_list);
      });
    });
    ShortMovieVideo().getlistBgm().then((List<String> _list) {
      setState(() {
        bgm.addAll(_list);
      });
    });
    ShortMovieVideo().getlistCartoon().then((List<String> _list) {
      setState(() {
        cartoon.addAll(_list);
      });
    });
    ShortMovieVideo().getlistComedy().then((List<String> _list) {
      setState(() {
        cartoon.addAll(_list);
      });
    });
    ShortMovieVideo().getlistDance().then((List<String> _list) {
      setState(() {
        dance.addAll(_list);
      });
    });
    ShortMovieVideo().getlistHorror().then((List<String> _list) {
      setState(() {
        horror.addAll(_list);
      });
    });
    ShortMovieVideo().getlistRomantic().then((List<String> _list) {
      setState(() {
        romantic.addAll(_list);
      });
    });
    ShortMovieVideo().getlistSad().then((List<String> _list) {
      setState(() {
        sad.addAll(_list);
      });
    });
    ShortMovieVideo().getlistTrending().then((List<String> _list) {
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
            SizedBox(height: 2),
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
                                    'assets/icon/short_movie/${subcategory[index]}.png'),
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
                  return customGridViewBuilder(shortMovieVideoAll);
                } else if (subcategoryIndex == 1) {
                  return customGridViewBuilder(action);
                } else if (subcategoryIndex == 2) {
                  return customGridViewBuilder(bgm);
                } else if (subcategoryIndex == 3) {
                  print(cartoon);
                  return customGridViewBuilder(cartoon);
                } else if (subcategoryIndex == 4) {
                  return customGridViewBuilder(comedy);
                } else if (subcategoryIndex == 5) {
                  return customGridViewBuilder(dance);
                } else if (subcategoryIndex == 6) {
                  return customGridViewBuilder(horror);
                } else if (subcategoryIndex == 7) {
                  return customGridViewBuilder(romantic);
                } else if (subcategoryIndex == 8) {
                  return customGridViewBuilder(sad);
                } else if (subcategoryIndex == 9) {
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

  List<String> recentList = ['Action', 'Comedy', 'Dance', 'Horror', 'Sad'];

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
