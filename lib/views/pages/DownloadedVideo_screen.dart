import 'dart:io';

import 'package:advance_video_share/views/widgets/custom_gridviewbuilder2.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';

class DownloadedVideoScreen extends StatefulWidget {

  DownloadedVideoScreen({Key key}) : super(key: key);

  @override
  _DownloadedVideoScreenState createState() => _DownloadedVideoScreenState();
}

class _DownloadedVideoScreenState extends State<DownloadedVideoScreen> {
  String categoryIcon = "";
  final List<String> mixStatusVideoAll = [];

  @override
  void initState() {
    super.initState();
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
              delegate: Search(mixStatusVideoAll),
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
          SizedBox(
            height: 8,
          ),
          Expanded(child: customGridViewBuilder2(mixStatusVideoAll))
        ],
      ),
    );
  }


  Future<void> getCategoryVideoList() async {
    // String categoryType = "";
    String _localPath = (await DownloadsPathProvider.downloadsDirectory).path + Platform.pathSeparator + 'AdvanceVideoShare'; // temp comment
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
