import 'package:advance_video_share/consts/AdState.dart';
import 'package:advance_video_share/views/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();

  final adState = AdState(initFuture);
  await FlutterDownloader.initialize();
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF8B0000),
        secondaryHeaderColor:  Color(0xFF8B0000),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: 'Biz Card- Photo & Video Status',
      home: SplashScreen(), //Splash Screen
      // home: UnitTest(), //Splash Screen
    );
  }
}
