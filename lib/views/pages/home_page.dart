import 'package:advance_video_share/views/widgets/home_page_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List mainCategoryList = [
    'Make Your Business Card Status',
    'Mix Status Video',
    'Short Movie Video',
    'Festive Status',
    'Kids Zone',
    'Old Songs Video',
    'Photo Status',
    'Create Your Own Video'
  ];

  final List photos = [
    'a',
    'a',
    'a',
    'a',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Everydat Status, Businesscard, photo & video status'),
      ),
      drawer: homePageDrawer(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: mainCategoryList.length,
          // itemCount: 2,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  // title: Text(mainCategoryList[index]),
                  title: Stack(
                    children: [
                      Image.asset('assets/photos/background_of_text.png'),
                      Positioned(
                        top: 14,
                        child: Text(
                          mainCategoryList[index],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      )
                    ],
                  ),
                  trailing: TextButton(
                    child: Text('See All'),
                    onPressed: () {},
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
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
            );
          },
        ),
      ),
    );
  }
}

// NetworkImage(
//                                       'http://alakshyatechno.tech/video/image/1.png'),
