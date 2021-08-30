import 'dart:convert';
import 'package:advance_video_share/consts/constants.dart';
import 'package:http/http.dart';

class MixStatusVideo {
  Future<List<String>> getlistAll() async {
    final url = Uri.parse('$apiBaseURL/0/2');
    Response response = await get(url);
    if (response.statusCode == 200) {
      List<String> videoUrlList = [];
      var jsonConvert = jsonDecode(response.body);
      String videoPath = jsonConvert['video_path'];
      List outputList = jsonConvert['output']['data'];
      for (var i = 0; i <= 7; i++) {
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
    final url = Uri.parse('$apiBaseURL/7/2');
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
    final url = Uri.parse('$apiBaseURL/4/2');
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
  Future<List<String>> getlistBikeLover() async {
    final url = Uri.parse('$apiBaseURL/15/2');
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
  Future<List<String>> getlistCarLover() async {
    final url = Uri.parse('$apiBaseURL/17/2');
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
    final url = Uri.parse('$apiBaseURL/11/2');
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
    final url = Uri.parse('$apiBaseURL/5/2');
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
  Future<List<String>> getlistFestival() async {
    final url = Uri.parse('$apiBaseURL/13/2');
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
  Future<List<String>> getlistGarba() async {
    final url = Uri.parse('$apiBaseURL/12/2');
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
  Future<List<String>> getlistGod() async {
    final url = Uri.parse('$apiBaseURL/2/2');
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
    final url = Uri.parse('$apiBaseURL/6/2');
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
  Future<List<String>> getlistLove() async {
    final url = Uri.parse('$apiBaseURL/8/2');
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
  Future<List<String>> getlistMother() async {
    final url = Uri.parse('$apiBaseURL/3/2');
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
  Future<List<String>> getlistNature() async {
    final url = Uri.parse('$apiBaseURL/14/2');
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
  Future<List<String>> getlistRoadTrip() async {
    final url = Uri.parse('$apiBaseURL/16/2');
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
    final url = Uri.parse('$apiBaseURL/10/2');
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
    final url = Uri.parse('$apiBaseURL/9/2');
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
  Future<List<String>> getlistSport() async {
    final url = Uri.parse('$apiBaseURL/18/2');
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
    final url = Uri.parse('$apiBaseURL/1/2');
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
