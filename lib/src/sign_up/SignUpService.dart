import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:momentrip/src/common/models/DefaultResponse.dart';
import 'package:momentrip/src/sign_up/models/SignUpParams.dart';

import '../../main.dart';
import 'interfaces/SignUpView.dart';

class SignUpService {
  final SignUpView mSignUpView;

  SignUpService(this.mSignUpView);

  void postUser(BuildContext buildContext, String name, String birth, String email, String password) async {
    Response response = await MyApp.getDio().post("/signUp",
        data: SignUpParams(
                userBirth: birth,
                userEmail: email,
                userPw: password,
                userName: name)
            .toJson());
    DefaultResponse defaultResponse = DefaultResponse.fromJson(response.data);
    if (defaultResponse == null) {
      mSignUpView.validateFailure(buildContext);
      return;
    }
    if (!defaultResponse.isSuccess) {
      mSignUpView.validateSuccess(buildContext, defaultResponse);
    }
    mSignUpView.validateSuccess(buildContext, defaultResponse);
  }
}
