import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:momentrip/src/sign_in/interfaces/SignInView.dart';
import 'package:momentrip/src/sign_in/models/SignInResponse.dart';

import '../../main.dart';
import 'models/SignInParams.dart';

class SignInService {
  final SignInView mSignInView;

  SignInService(this.mSignInView);

  void postToken(BuildContext context, String email, String password) async {
    Response response = await MyApp.getDio().post("/signIn",
        data: SignInParams(userEmail: email, userPw: password));
    SignInResponse signInResponse = SignInResponse.fromJson(response.data);
    if (signInResponse == null) {
      mSignInView.validateFailure(context);
      return;
    }
    mSignInView.validateSuccess(context, signInResponse);
  }
}