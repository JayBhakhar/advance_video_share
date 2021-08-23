import 'dart:convert';

import 'package:advance_video_share/consts/constants.dart';
import 'package:http/http.dart';

class MixStatusVideo {
  Future<List> getlist() async {
    final url = Uri.parse('$apiBaseURL/0/2');
    Response response = await get(url);
    if (response.statusCode == 200) {
      List video_url_list = [];
      var jsonConvert = jsonDecode(response.body);
      String video_path = jsonConvert['video_path'];
      List outputList = jsonConvert['output']['data'];
      for (var i = 0; i <= 5; i++) {  // for loop :- url list 
        String video_name = outputList[i]['video_name'];
        String video_url = video_path + '/' + video_name;
        video_url_list.add(video_url);
      }
      return video_url_list;
    }
  }
}
