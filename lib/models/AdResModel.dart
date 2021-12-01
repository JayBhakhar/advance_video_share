// To parse this JSON data, do
//
//     final adResModel = adResModelFromJson(jsonString);

import 'dart:convert';

AdResModel adResModelFromJson(String str) => AdResModel.fromJson(json.decode(str));

String adResModelToJson(AdResModel data) => json.encode(data.toJson());

class AdResModel {
  AdResModel({
    this.appPackage,
    this.appId,
    this.bannerAd,
    this.interstitialAd,
    this.nativaAds,
    this.appOpenAd,
    this.adShow,
  });

  String appPackage;
  String appId;
  String bannerAd;
  String interstitialAd;
  String nativaAds;
  String appOpenAd;
  String adShow;

  factory AdResModel.fromJson(Map<String, dynamic> json) => AdResModel(
    appPackage: json["AppPackage"] == null ? null : json["AppPackage"],
    appId: json["AppId"] == null ? null : json["AppId"],
    bannerAd: json["BannerAd"] == null ? null : json["BannerAd"],
    interstitialAd: json["InterstitialAd"] == null ? null : json["InterstitialAd"],
    nativaAds: json["NativaAds"] == null ? null : json["NativaAds"],
    appOpenAd: json["AppOpenAd"] == null ? null : json["AppOpenAd"],
    adShow: json["AdShow"] == null ? null : json["AdShow"],
  );

  Map<String, dynamic> toJson() => {
    "AppPackage": appPackage == null ? null : appPackage,
    "AppId": appId == null ? null : appId,
    "BannerAd": bannerAd == null ? null : bannerAd,
    "InterstitialAd": interstitialAd == null ? null : interstitialAd,
    "NativaAds": nativaAds == null ? null : nativaAds,
    "AppOpenAd": appOpenAd == null ? null : appOpenAd,
    "AdShow": adShow == null ? null : adShow,
  };
}
