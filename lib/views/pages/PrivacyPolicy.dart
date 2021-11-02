import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:advance_video_share/consts/constants.dart';
import 'package:advance_video_share/views/widgets/VideoItem.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:photo_view/photo_view.dart';

import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:math' as math; // import this
import 'package:whatsapp_share/whatsapp_share.dart';

class PrivacyPolicy extends StatefulWidget {

  @override
  PrivacyPolicyState createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  bool isWebLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body:   Stack(children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(privacyURL)),
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                    cacheEnabled: false,
                    horizontalScrollBarEnabled: true,
                    disableVerticalScroll: false,
                    // debuggingEnabled: true,
                    useOnDownloadStart: true,
                    javaScriptEnabled: true,
                    preferredContentMode: UserPreferredContentMode.MOBILE,
                    supportZoom: true,
                    verticalScrollBarEnabled: true,
                    useShouldOverrideUrlLoading: true),
                android: AndroidInAppWebViewOptions(
                    cacheMode: AndroidCacheMode.LOAD_NO_CACHE,
                    clearSessionCache: true,
                    useShouldInterceptRequest: true,
                    loadWithOverviewMode: true,
                    useWideViewPort: false,
                    allowContentAccess: true),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                )),
            // onWebViewCreated: (InAppWebViewController controller) {
            //   webViewController = controller;
            //   webViewController.clearCache();
            //   final cookieManager = CookieManager();
            //   cookieManager.deleteAllCookies();
            // },
            // onReceivedServerTrustAuthRequest: (InAppWebViewController controller, ServerTrustChallenge challenge) async {
            //   return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
            // },
            shouldOverrideUrlLoading: (controller, request) async {
              var url = request.toString();
              var uri = Uri.parse(url);
              print("shouldOverrideUrlLoading.. $url");
              if (uri.toString().contains("user_id=") &&
                  uri.toString().contains("code=")) {
              }
              return NavigationActionPolicy.ALLOW;
            },
            onConsoleMessage: (controller, ConsoleMessage consoleMessage) {
              print("Webview console message======" + consoleMessage.message);
            },
            onProgressChanged: (InAppWebViewController controller, int progress) {
              setState(() {
                if (progress == 100) {
                  isWebLoading = false;
                } else {
                  isWebLoading = true;
                }
                print("progress===" + progress.toString());
              });
            },
          ),
          // ProgressIndicatorLoader(AppColors.primary, isWebLoading)

          isWebLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container()
        ]),
      ),
    );
  }

// @override
// void dispose() {
//   super.dispose();
//   _controller.dispose();
// }
}
