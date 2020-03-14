import 'package:dio/dio.dart';

import '../main.dart';

class XAccessTokenInterceptor extends InterceptorsWrapper {

  @override
  Future onRequest(RequestOptions options) {
    final String jwtToken = MyApp.sSharedPreferences.get(MyApp.X_ACCESS_TOKEN);
    if (jwtToken != null) {
      options.headers.addAll({MyApp.X_ACCESS_TOKEN : jwtToken});
    }
    return super.onRequest(options);
  }
}