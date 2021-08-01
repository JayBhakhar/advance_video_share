import 'package:advance_video_share/unit_test.dart';
import 'package:advance_video_share/views/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advance Video Share',
      home: Test(),
      // home: HomePage(), //Home page
    );
  }
}

