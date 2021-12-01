import 'package:advance_video_share/consts/AppColors.dart';
import 'package:advance_video_share/views/pages/BussinessForm.dart';
import 'package:advance_video_share/views/pages/DownloadedCard_screen.dart';
import 'package:advance_video_share/views/pages/DownloadedVideo_screen.dart';
import 'package:advance_video_share/views/pages/PrivacyPolicy.dart';
import 'package:advance_video_share/views/pages/play_video_landscape.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share/share.dart';

Widget homePageDrawer(BuildContext context) {
  return SafeArea(
    child: Drawer(
      child: Column(
        children: [
          SizedBox(height: 16,),
          Center(
            child: Image.asset(
              'assets/icon/icon.png',
              width: 84,
              height: 84,
            ),
          ),
          ListTile(
            title: Text('Biz Card- Photo & Video Status',style: TextStyle(color:  Colors.black,fontSize: 17,height: 1,fontWeight: FontWeight.bold,fontFamily: "YoungSerif")),
          ),
          ListTile(
            leading: IconTitle(Icons.share),
            title: TextTitle('Share App'),
            onTap: () {
              Navigator.of(context).pop();
              final RenderBox box = context.findRenderObject() as RenderBox;
              Share.share("Check this amazing Biz Card- Photo & Video Status App at google play " +
                      "https://play.google.com/store/apps/details?id=com.cropvideo.advance_video_share",
                  subject: 'Share App',
                  sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size)
                  .whenComplete(() {});
            },
          ),
          ListTile(
            leading: IconTitle(Icons.credit_card),
            title: TextTitle('My Business Card'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DownloadedCardScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: IconTitle(Icons.download_sharp),
            title: TextTitle('My Downloads'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DownloadedVideoScreen(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: IconTitle(Icons.policy_outlined),
          //   title: TextTitle('Create your own video'),
          // ),
          ListTile(
            leading: IconTitle(Icons.info_outline),
            title: TextTitle('Privacy Policy'),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(),
                ),
              );
            },
          ),
          ListTile(
            leading: IconTitle(Icons.star_rate_outlined),
            title: TextTitle('Rate App'),
            onTap: () async {
              Navigator.of(context).pop();
              final InAppReview inAppReview = InAppReview.instance;
              if (await inAppReview.isAvailable()) {
              inAppReview.requestReview();
              }
            },
          ),
        ],
      ),
    ),
  );
}

Widget TextTitle(String text) {
  return Text(
    text,
    style: TextStyle(color: AppColors.appRed,fontFamily: "Source Sans Pro"),
  );
}

Widget IconTitle(IconData icon) {
  return Icon(
    icon,
    color: AppColors.appRed,
  );
}
