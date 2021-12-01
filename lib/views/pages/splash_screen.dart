import 'dart:convert';
import 'dart:io';

import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/models/AdResModel.dart';
import 'package:advance_video_share/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    // Future.delayed(const Duration(milliseconds: 2500), () {
    //   _makePath();
    // });
    getBalance();

    //
  }

   getBalance() async {
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': "application/json",
      };
      var response = await http.get(Uri.parse(adURL), headers: headers);

      print("ad response : ----" + response.body);
      if (response.statusCode == 200) {
        AdResModel adResModel = new AdResModel.fromJson(json.decode(response.body));
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("bennerId", adResModel.bannerAd);
        prefs.setString("nativeId", adResModel.nativaAds);
        prefs.setString("instId", adResModel.interstitialAd);
        prefs.setString("appopenad", adResModel.appOpenAd);
      }
      _makePath();
    } on SocketException catch (e) {
      _makePath();
      print(e.message);
    } on Exception catch (e) {
      _makePath();
      print(e.toString());
    }
  }

  _makePath() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [

            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/icon/icon.png',
                    width: 175,
                    height: 175,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Everyday BusinessCard',
                  style: /*Theme.of(context).textTheme.bodyText1*/TextStyle(color:  Colors.white,fontSize: 17,fontWeight: FontWeight.bold,fontFamily: "YoungSerif"),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text('Share your Photo & Video status',style: TextStyle(color:  Colors.white,fontSize: 16,fontFamily: "Source Sans Pro"),),
                SizedBox(
                  height: 12.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
