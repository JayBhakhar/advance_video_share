import 'package:advance_video_share/views/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _makePath();
  }

  _makePath() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            Center(
              child: Image.asset(
                'assets/icon/icon.png',
                width: 175,
                height: 175,
              ),
            ),
            SizedBox(
              height: 230,
            ),
            Text(
              'Everyday Status',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 5,
            ),
            Text('Business card, photo & video status'),
          ],
        ),
      ),
    );
  }
}
