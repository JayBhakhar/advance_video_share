import 'dart:convert';
import 'package:advance_video_share/consts/constants.dart';
import 'package:http/http.dart';

class ShortMovieVideo {
  Future<List<String>> getlistAll() async {
    final url = Uri.parse('$apiBaseURL/0/3');
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

  Future<List<String>> getlistAction() async {
    final url = Uri.parse('$apiBaseURL/19/3');
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

  Future<List<String>> getlistComedy() async {
    final url = Uri.parse('$apiBaseURL/22/3');
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

  Future<List<String>> getlistBgm() async {
    final url = Uri.parse('$apiBaseURL/20/3');
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

  Future<List<String>> getlistHorror() async {
    final url = Uri.parse('$apiBaseURL/24/3');
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

  Future<List<String>> getlistSad() async {
    final url = Uri.parse('$apiBaseURL/26/3');
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

  Future<List<String>> getlistRomantic() async {
    final url = Uri.parse('$apiBaseURL/25/3');
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

  Future<List<String>> getlistTrending() async {
    final url = Uri.parse('$apiBaseURL/27/3');
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

  Future<List<String>> getlistCartoon() async {
    final url = Uri.parse('$apiBaseURL/21/3');
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

  Future<List<String>> getlistDance() async {
    final url = Uri.parse('$apiBaseURL/23/3');
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
