import 'dart:io';

import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:advance_video_share/views/pages/play_video_landscape2.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

Widget customGridViewBuilder2(List<String> _list,BuildContext context) {
  return GridView.count(
      shrinkWrap: true,
      physics: ScrollPhysics(),
    crossAxisCount: 2,
    childAspectRatio: 0.8,
      children: List.generate(_list.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            child:
            Container(

              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0)),
              child: !_list[index].endsWith("mp4")?
              Image.file(File(_list[index]),   fit: BoxFit.fill,):VideoPlayer(
                VideoPlayerController.network(_list[index])
                  ..initialize(),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayVideoLandscape2(videoUrl:_list[index],videoUrls: _list,),
                ),
              );
            },
          ),
        );
      }),

      );
}
