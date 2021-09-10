import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

Widget customGridViewBuilder(List<String> _list) {
  return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5 / 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      itemCount: _list.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            child: Container(
              height: gridViewContainerHeight,
              width: gridViewContainerWidth,
              child: VideoPlayer(
                VideoPlayerController.network(_list[index])..initialize(),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayVideoLandscape(_list[index]),
                ),
              );
            },
          ),
        );
      });
}
