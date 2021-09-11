import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/services/photoStatus_list.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:advance_video_share/views/widgets/custom_gridviewbuilder.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PhotoStatusScreen extends StatefulWidget {
  @override
  _PhotoStatusScreenState createState() => _PhotoStatusScreenState();
}

class _PhotoStatusScreenState extends State<PhotoStatusScreen> {
  final List<String> subcategory = [
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

  final List<String> photoStatusAll = [];
  final List<String> business = [];
  final List<String> festival = [];
  final List<String> friendship = [];
  final List<String> god = [];
  final List<String> love = [];
  final List<String> mix = [];
  final List<String> mother = [];
  final List<String> motivation = [];
  final List<String> navratri = [];
  final List<String> romantic = [];
  final List<String> sad = [];
  final List<String> shayri = [];

  int subcategoryIndex = 0;

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    PhotoStatus().getlistAll().then((List<String> _list) {
      setState(() {
        photoStatusAll.addAll(_list);
      });
    });
    PhotoStatus().getlistBusiness().then((List<String> _list) {
      setState(() {
        business.addAll(_list);
      });
    });
    PhotoStatus().getlistFestival().then((List<String> _list) {
      setState(() {
        festival.addAll(_list);
      });
    });
    PhotoStatus().getlistFriendship().then((List<String> _list) {
      setState(() {
        friendship.addAll(_list);
      });
    });
    PhotoStatus().getlistGod().then((List<String> _list) {
      setState(() {
        god.addAll(_list);
      });
    });
    PhotoStatus().getlistLove().then((List<String> _list) {
      setState(() {
        love.addAll(_list);
      });
    });
    PhotoStatus().getlistMix().then((List<String> _list) {
      setState(() {
        mix.addAll(_list);
      });
    });
    PhotoStatus().getlistMother().then((List<String> _list) {
      setState(() {
        mother.addAll(_list);
      });
    });
    PhotoStatus().getlistMotivation().then((List<String> _list) {
      setState(() {
        motivation.addAll(_list);
      });
    });
    PhotoStatus().getlistNavratri().then((List<String> _list) {
      setState(() {
        navratri.addAll(_list);
      });
    });
    PhotoStatus().getlistRomantic().then((List<String> _list) {
      setState(() {
        romantic.addAll(_list);
      });
    });
    PhotoStatus().getlistSad().then((List<String> _list) {
      setState(() {
        sad.addAll(_list);
      });
    });
    PhotoStatus().getlistShayri().then((List<String> _list) {
      setState(() {
        shayri.addAll(_list);
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
                                    'assets/icon/photo_status/${subcategory[index]}.png'),
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
                  return customGridViewBuilder(photoStatusAll);
                } else if (subcategoryIndex == 1) {
                  return customGridViewBuilder(business);
                } else if (subcategoryIndex == 2) {
                  return customGridViewBuilder(festival);
                } else if (subcategoryIndex == 3) {
                  return customGridViewBuilder(friendship);
                } else if (subcategoryIndex == 4) {
                  return customGridViewBuilder(god);
                } else if (subcategoryIndex == 5) {
                  return customGridViewBuilder(love);
                } else if (subcategoryIndex == 6) {
                  return customGridViewBuilder(mix);
                } else if (subcategoryIndex == 7) {
                  return customGridViewBuilder(mother);
                } else if (subcategoryIndex == 8) {
                  return customGridViewBuilder(motivation);
                } else if (subcategoryIndex == 9) {
                  return customGridViewBuilder(navratri);
                } else if (subcategoryIndex == 10) {
                  return customGridViewBuilder(romantic);
                } else if (subcategoryIndex == 11) {
                  return customGridViewBuilder(sad);
                } else if (subcategoryIndex == 12) {
                  print(shayri);
                  return customGridViewBuilder(shayri);
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

  List<String> recentList = [
    'Business',
    'God',
    'Motivation',
    'Romantic',
    'Shayari',
  ];

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
