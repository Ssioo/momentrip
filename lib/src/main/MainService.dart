import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:momentrip/src/main/models/MainParams.dart';

import '../../main.dart';
import 'interfaces/MainView.dart';
import '../common/models/DefaultResponse.dart';

class MainService {
  final MainView mMainView;

  MainService(this.mMainView);

  void postTrip(BuildContext buildContext, String starTime, String endTime) async {
    Response response = await MyApp.getDio().post("/trip", data: MainParams(startDate: starTime, endDate: endTime));
    DefaultResponse defaultResponse = DefaultResponse.fromJson(response.data);
    if (defaultResponse == null || !defaultResponse.isSuccess) {
      mMainView.validateFailure(buildContext);
      return;
    }
    mMainView.validateSuccess(buildContext, defaultResponse);
  }
}
