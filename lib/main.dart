import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:momentrip/src/camera/CameraPage.dart';
import 'package:momentrip/src/camera_result/CameraResultPage.dart';
import 'package:momentrip/src/story/StoryPage.dart';
import 'package:momentrip/src/travel/TravelPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/XAccessTokenInterceptor.dart';
import 'src/main/MainPage.dart';
import 'src/settings/SettingsPage.dart';
import 'src/sign_in/SignInPage.dart';
import 'src/sign_select/SignSelctPage.dart';
import 'src/sign_up/SignUpPage.dart';
import 'src/splash/SplashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // 테스트 서버 주소
  static final String BASE_URL = "http://15.164.90.221:3333/"; // TEST SERVER
  // 실서버 주소
//  static final String BASE_URL = "https://template.sio.com"; // PRODUCTION SERVER

  // Dio 인스턴스
  static Dio dio;

  // SharedPreference
  static SharedPreferences sSharedPreferences;

  // SharedPreferences 키 값
  static final String X_ACCESS_TOKEN = "X-ACCESS-TOKEN";

  // Login Type
  static final String LOGIN_TYPE = "LOGIN-TYPE";
  static final String LOGIN_TYPE_KAKAO = "kakao";
  static final String LOGIN_TYPE_NORMAL = "normal";

  static Dio getDio() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 5000,
      );
      dio = Dio(options);

      dio.interceptors.add(XAccessTokenInterceptor());
      dio.interceptors.add(LogInterceptor(responseBody: true));
    }
    return dio;
  }

  static getSharedPreferences() async {
    if (sSharedPreferences == null) {
      sSharedPreferences = await SharedPreferences.getInstance();
    }

    Crashlytics.instance.enableInDevMode = true;
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
  }

  @override
  Widget build(BuildContext context) {

    getSharedPreferences();
    KakaoContext.clientId = "6b9b8c225bbb9a1d3a14e3cd23ef6632";


    return MaterialApp(
      title: 'Momentrip',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ko')
      ],
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/main': (context) => MainPage(),
        '/travel': (context) => TravelPage(),
        '/sign_select': (context) => SignSelectPage(),
        '/sign_up' : (context) => SignUpPage(),
        '/sign_in' : (context) => SignInPage(),
        '/camera' : (context) => CameraPage(),
        '/settings': (context) => SettingsPage(),
        '/camera/result' : (context) => CameraResultPage(),
        '/travel/story': (context) => StoryPage(),
      },
    );
  }
}
