import 'dart:io';

import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:advance_video_share/views/pages/play_video_landscape2.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

Widget customGridViewCard(List<String> _list) {
  return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 1,
          // childAspectRatio: 1,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      itemCount: _list.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            child:
            Container(
              // height: 150,
              // width: 140,
              // width: 140,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0)),
              child: !_list[index].endsWith("mp4")?
              Image.file(File(_list[index]),   height: 150,
                width: 140,fit: BoxFit.fill,):VideoPlayer(
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
      });
}
