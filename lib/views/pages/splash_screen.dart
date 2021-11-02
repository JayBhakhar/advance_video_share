import 'package:advance_video_share/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    Future.delayed(const Duration(milliseconds: 2500), () {
      _makePath();
    });

    //
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
