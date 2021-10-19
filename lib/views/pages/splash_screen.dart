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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Center(
              child: Image.asset(
                'assets/icon/icon.png',
                width: 175,
                height: 175,
              ),
            ),
            Align(
            alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Everyday Status',
                    style: /*Theme.of(context).textTheme.bodyText1*/TextStyle(color:  Colors.white,fontSize: 17,fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text('Business card, photo & video status',style: TextStyle(color:  Colors.white,fontSize: 16),),
                  SizedBox(
                    height: 12.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
