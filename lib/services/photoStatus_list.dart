import 'dart:convert';
import 'package:advance_video_share/consts/constants.dart';
import 'package:http/http.dart';

class PhotoStatus {
  Future<List<String>> getlistAll() async {
    final url = Uri.parse('$apiBaseURL/0/7');
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

  Future<List<String>> getlistMix() async {
    final url = Uri.parse('$apiBaseURL/40/7');
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

  Future<List<String>> getlistMotivation() async {
    final url = Uri.parse('$apiBaseURL/41/7');
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

  Future<List<String>> getlistBusiness() async {
    final url = Uri.parse('$apiBaseURL/42/7');
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
    final url = Uri.parse('$apiBaseURL/43/7');
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

  Future<List<String>> getlistShayri() async {
    final url = Uri.parse('$apiBaseURL/44/7');
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
    final url = Uri.parse('$apiBaseURL/45/7');
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
    final url = Uri.parse('$apiBaseURL/46/7');
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

  Future<List<String>> getlistNavratri() async {
    final url = Uri.parse('$apiBaseURL/47/7');
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
    final url = Uri.parse('$apiBaseURL/48/7');
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
    final url = Uri.parse('$apiBaseURL/49/7');
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
    final url = Uri.parse('$apiBaseURL/50/7');
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

  Future<List<String>> getlistFriendship() async {
    final url = Uri.parse('$apiBaseURL/51/7');
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
