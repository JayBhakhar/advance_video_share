import 'package:advance_video_share/services/mix_status_video_api.dart';
import 'package:advance_video_share/views/widgets/home_page_drawer.dart';
import 'package:advance_video_share/views/widgets/main_category_title.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List mainCategoryList = [
    'Make Your Business Card Status',
    'Mix Status Video', // 1/2
    'Short Movie Video', // 0/3
    'Festive Status', // 0/4
    'Kids Zone', // 0/5
    'Old Songs Video', // 0/6
    'Photo Status', // 0/7
    'Create Your Own Video' // 0/8
  ];

  final List photos = [
    'a',
    'a',
    'a',
    'a',
  ];

  @override
  Widget build(BuildContext context) {
    MixStatusVideo().getlist().then((List _list) {
      print(_list);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Everyday Status, Businesscard, photo & video status'),
      ),
      drawer: homePageDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  MainCategoryTitle(
                    titleText: "Make Your Business Card Status",
                    onPressed: () {},
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: 100,
                            width: 100,
                            color: Colors.amberAccent,
                            child: Image.asset('assets/photos/09.jpg'),
                          ),
                          onTap: () {},
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 60,
                          color: Colors.amberAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MainCategoryTitle(
                titleText: 'Mix Status Video',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// NetworkImage(
//                                       'http://alakshyatechno.tech/video/image/1.png'),

// 1/2 :- main catalofy
// http://alakshyatechno.tech/subcategorylist 
// route :- all 0 