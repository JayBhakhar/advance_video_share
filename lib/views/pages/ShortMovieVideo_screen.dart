import 'package:advance_video_share/services/api_video_list.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
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

  final List<String> shortMovieVideoUrlList = [];

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    ShortMovieVideo().getlist().then((List<String> _list) {
      setState(() {
        shortMovieVideoUrlList.addAll(_list);
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
                    List<Widget>.generate(subcategory.length, (int index1) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      // color: Colors.amberAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              height: 80,
                              child: Image.asset(
                                  'assets/icon/mix_status_icon/${subcategory[index1]}.png'),
                            ),
                          ),
                          Text(subcategory[index1]),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: shortMovieVideoUrlList.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      child: Container(
                        height: 200,
                        width: 140,
                        child: VideoPlayer(
                          VideoPlayerController.network(
                              shortMovieVideoUrlList[index])
                            ..initialize(),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayVideoLandscape(
                                shortMovieVideoUrlList[index]),
                          ),
                        );
                      },
                    ),
                  );
                }),
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
