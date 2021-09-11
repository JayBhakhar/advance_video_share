import 'dart:convert';
import 'package:advance_video_share/consts/constants.dart';
import 'package:http/http.dart';

class FestiveStatus {
  Future<List<String>> getlistAll() async {
    final url = Uri.parse('$apiBaseURL/28/4');
    Response response = await get(url);
    if (response.statusCode == 200) {
      List<String> videoUrlList = [];
      var jsonConvert = jsonDecode(response.body);
      String videoPath = jsonConvert['video_path'];
      List outputList = jsonConvert['output']['data'];
      for (var i = 0; i <= 2; i++) {
        // for loop :- url list
        String videoName = outputList[i]['video_name'];
        String videoUrl = videoPath + '/' + videoName;
        videoUrlList.add(videoUrl);
      }
      return videoUrlList;
    }
    return null; // error messange of internet probelm
  }
}
