import 'dart:convert';
import 'package:advance_video_share/models/listModel.dart';
import 'package:http/http.dart';


class MixStatusVideo {

  Future<ListModel> getSubCategoryListAll(String url,String page) async {
    // final url = Uri.parse('$apiBaseURL/0/2');
    print("url--"+url+"?page=$page");
    Response response = await get(Uri.parse(url+"?page=$page"));
    // print("response="+response.body.toString());
    if (response.statusCode == 200) {
      List<String> videoUrlList = [];
      var jsonConvert = jsonDecode(response.body);
      String videoPath = jsonConvert['video_path'];
      String imagePath = jsonConvert['image_path'];
      List outputList = jsonConvert['output']['data'];
      print("outputList.length--"+outputList.length.toString());
      for (var i = 0; i < outputList.length; i++) {
        // for loop :- url list
        String videoName = outputList[i]['video_name'];
        String imageName = outputList[i]['thambnail'];
        String videoUrl = videoPath + '/' + videoName;
        String imageUrl = imagePath + '/' + imageName;
        videoUrlList.add(videoUrl+"~"+imageUrl);
      }

      ListModel listModel = new ListModel(videoUrlList,jsonConvert['output']['total']);
      print("total=="+jsonConvert['output']['total'].toString());
      return listModel;
    }
    return null; // error messange of internet probelm
  }

}


