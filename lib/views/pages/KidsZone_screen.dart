import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/services/kidsZone_list.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class KindsZoneScreen extends StatefulWidget {
  @override
  _KindsZoneScreenState createState() => _KindsZoneScreenState();
}

class _KindsZoneScreenState extends State<KindsZoneScreen> {
  final List<String> subcategory = [
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

  final List<String> kindsZoneAll = [];
  final List<String> alladin = [];
  final List<String> animal = [];
  final List<String> chottaBhim = [];
  final List<String> duckTales = [];
  final List<String> jungleBook = [];
  final List<String> jurassicPark = [];
  final List<String> motuPatlu = [];
  final List<String> mrBean = [];
  final List<String> talkingTom = [];
  final List<String> tomAndJerry = [];

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    KidsZone().getlistAll().then((List<String> _list) {
      setState(() {
        kindsZoneAll.addAll(_list);
      });
      print(kindsZoneAll);
    });
    // KidsZone().getlistAlladin().then((List<String> _list) {
    //   setState(() {
    //     kindsZoneAll.addAll(_list);
    //   });
    //   print(kindsZoneAll);
    // });
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
                      print(index);
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
                                    'assets/icon/kids_zone/${subcategory[index]}.png'),
                              ),
                            ),
                            Text(subcategory[index], style: subcategoryTextStyle,),
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
            GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.5 / 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),
                itemCount: kindsZoneAll.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      child: Container(
                        height: 200,
                        width: 140,
                        // child: VideoPlayer(
                        //   VideoPlayerController.network(kindsZoneAll[index])
                        //     ..initialize(),
                        // ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlayVideoLandscape(kindsZoneAll[index]),
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

  List<String> recentList = [
    'Alladin',
    'Duck tales',
    'Jungle book',
    'Motu patlu',
    'Tom and jerry',
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
