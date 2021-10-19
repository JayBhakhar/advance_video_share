import 'package:advance_video_share/views/pages/BussinessForm.dart';
import 'package:advance_video_share/views/pages/DownloadedVideo_screen.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:flutter/material.dart';

Widget homePageDrawer(BuildContext context) {
  return SafeArea(
    child: Drawer(
      child: Column(
        children: [
          ListTile(
            title: Text('Advance video share'),
          ),
          ListTile(
            leading: Icon(Icons.share_sharp),
            title: Text('Business card'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BussinessForm(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Downloads'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DownloadedVideoScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.policy_outlined),
            title: Text('Create your own video'),
          ),
        ],
      ),
    ),
  );
}
