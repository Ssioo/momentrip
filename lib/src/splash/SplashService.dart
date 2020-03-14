import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:momentrip/main.dart';
import 'package:momentrip/src/common/models/DefaultResponse.dart';
import 'package:momentrip/src/splash/interfaces/SplashView.dart';

class SplashService {
  final SplashView mSplashView;

  SplashService(this.mSplashView);

  void tryGetToken(BuildContext context) async {
    Response response = await MyApp.getDio().get("/jwt");
    DefaultResponse defaultResponse = DefaultResponse.fromJson(response.data);
    if (defaultResponse == null) {
      mSplashView.validateFailure(context);
      return;
    }
    mSplashView.validateSuccess(context, defaultResponse);
  }
}