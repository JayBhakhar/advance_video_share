import 'dart:convert';
import 'package:advance_video_share/consts/constants.dart';
import 'package:http/http.dart';

class MixStatusVideo {

  Future<List<String>> getSubCategoryListAll(String url) async {
    // final url = Uri.parse('$apiBaseURL/0/2');
    Response response = await get(Uri.parse(url));
    print("response="+response.body.toString());
    if (response.statusCode == 200) {
      List<String> videoUrlList = [];
      var jsonConvert = jsonDecode(response.body);
      String videoPath = jsonConvert['video_path'];
      String imagePath = jsonConvert['image_path'];
      List outputList = jsonConvert['output']['data'];
      for (var i = 0; i < outputList.length; i++) {
        // for loop :- url list
        String videoName = outputList[i]['video_name'];
        String imageName = outputList[i]['thambnail'];
        String videoUrl = videoPath + '/' + videoName;
        String imageUrl = imagePath + '/' + imageName;
        videoUrlList.add(videoUrl+"~"+imageUrl);
      }
      return videoUrlList;
    }
    return null; // error messange of internet probelm
  }

}
