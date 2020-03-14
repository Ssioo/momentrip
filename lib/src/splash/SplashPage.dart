import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:momentrip/main.dart';
import 'package:momentrip/src/common/models/DefaultResponse.dart';
import 'package:momentrip/src/splash/SplashService.dart';
import 'package:momentrip/src/splash/interfaces/SplashView.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget implements SplashView {
  @override
  Widget build(BuildContext context) {
    trySignIn(context);
    return Scaffold(
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          );
        },
      ),
    );
  }

  void trySignIn(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginType = sharedPreferences.getString(MyApp.LOGIN_TYPE);
    if (loginType == null) {
      Navigator.of(context).pushReplacementNamed('/sign_select');
      return;
    }
    if (loginType == MyApp.LOGIN_TYPE_KAKAO) {
      AccessToken token = await AccessTokenStore.instance.fromStore();
      if (token.refreshToken == null) {
        Navigator.of(context).pushReplacementNamed('/sign_select');
      } else {
        print("Access Token: " + token.accessToken);
        Navigator.of(context).pushReplacementNamed('/main');
      }
    } else if (loginType == MyApp.LOGIN_TYPE_NORMAL) {
      showProgressDialog(context);
      SplashService service = SplashService(this);
      service.tryGetToken(context);
    }
  }

  ProgressDialog dialog;
  showProgressDialog(BuildContext context) async {
    if (dialog == null) {
      dialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    }
    await dialog.show();
  }
  hideProgressDialog(BuildContext context) async {
    if (dialog != null && dialog.isShowing()) {
      dialog.hide();
    }
  }

  @override
  void validateFailure(BuildContext context) {
    hideProgressDialog(context);
    Navigator.pushReplacementNamed(context, "/sign_select");
  }

  @override
  void validateSuccess(BuildContext context, DefaultResponse response) {
    hideProgressDialog(context);
    Navigator.pushReplacementNamed(context, "/main");
  }

}