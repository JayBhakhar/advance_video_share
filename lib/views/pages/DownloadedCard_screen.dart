import 'dart:io';

import 'package:advance_video_share/consts/AdState.dart';
import 'package:advance_video_share/views/pages/play_video_landscape2.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class DownloadedCardScreen extends StatefulWidget {

  DownloadedCardScreen({Key key}) : super(key: key);

  @override
  _DownloadedCardScreenState createState() => _DownloadedCardScreenState();
}

class _DownloadedCardScreenState extends State<DownloadedCardScreen> {
  String categoryIcon = "";
  final List<String> mixStatusVideoAll = [];
  String adId = "";
  BannerAd banner;

  @override
  void initState() {
    super.initState();
    _initPreference();
    getCategoryVideoList();
  }

  _initPreference() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        adId = prefs.getString("bennerId");
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
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
        title: Text(
          "Your Business Card"
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/icon/icon.png',
            width: 32,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          SizedBox(
            height: 8,
          ),
          Expanded(child: GridView.count(
              childAspectRatio: 1.2,
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 8.0,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: List.generate(mixStatusVideoAll.length, (index){
                return Container(

                  height: 150,
                  width: 150,
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Align(

                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          child:
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: !mixStatusVideoAll[index].endsWith("mp4")?
                            Image.file(File(mixStatusVideoAll[index]),   height: 150,
                              width: 150,fit: BoxFit.fill,):VideoPlayer(
                              VideoPlayerController.network(mixStatusVideoAll[index])
                                ..initialize(),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayVideoLandscape2(videoUrl:mixStatusVideoAll[index],videoUrls: mixStatusVideoAll,),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: ()  {
                                deleteFile(index);
                              },
                              child: Icon(Icons.remove_circle, color: Colors.red, size: 36)))
                    ],
                  ),
                );
              })
          )),
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
    );
  }


  Future<void> getCategoryVideoList() async {
    // String categoryType = "";
    String _localPath = (await DownloadsPathProvider.downloadsDirectory).path + Platform.pathSeparator + 'BusinessCard'; // temp comment
    print("LOCAL path==" + _localPath);
    Directory dir = Directory(_localPath);
    String mp3Path = dir.toString();
    print(mp3Path);
    List<FileSystemEntity> _files;
    List<FileSystemEntity> _songs = [];
    try {
      _files = dir.listSync(recursive: true, followLinks: false);
      setState(() {
        for (FileSystemEntity entity in _files) {
          String path = entity.path;
          //  if(path.endsWith('.mp4'))
          _songs.add(entity);
          mixStatusVideoAll.add(path);
        }
      });

      print(_songs);
      print(_songs.length);
    }catch(ex){}
  }

  Future<int> deleteFile(int index) async {
    try {
      final file = await File(mixStatusVideoAll[index]);
      await file.delete();
      setState(() {
        mixStatusVideoAll.removeAt(index);
      });
    } catch (e) {
      return 0;
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
