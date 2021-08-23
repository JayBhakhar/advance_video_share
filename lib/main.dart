import 'package:advance_video_share/unit_test.dart';
import 'package:advance_video_share/views/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: 'Advance Video Share',
      home: SplashScreen(), //Splash Screen
      // home: UnitTest(), //Splash Screen
    );
  }
}
