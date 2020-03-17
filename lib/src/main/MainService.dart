import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:momentrip/src/main/models/MainParams.dart';
import 'package:momentrip/src/main/models/MainResponse.dart';

import '../../main.dart';
import 'interfaces/MainView.dart';

class MainService {
  final MainView mMainView;

  MainService(this.mMainView);

  void postTrip(BuildContext buildContext, String starTime, String endTime) async {
    Response response = await MyApp.getDio().post("/trip", data: MainParams(startDate: starTime, endDate: endTime));
    MainObjectResponse mainObjectResponse = MainObjectResponse.fromJson(response.data);
    if (mainObjectResponse == null || !mainObjectResponse.isSuccess) {
      mMainView.validateFailure(buildContext);
      return;
    }
    mMainView.validateSuccess(buildContext, mainObjectResponse);
  }

  void getStatus(BuildContext context) async {
    Response response = await MyApp.getDio().get("/tripstatus");
    MainResponse mainResponse = MainResponse.fromJson(response.data);
    if (mainResponse == null || !mainResponse.isSuccess) {
      mMainView.validateStatusFailure(context);
      return;
    }
    mMainView.validateStatusSuccess(context, mainResponse);
  }
}
