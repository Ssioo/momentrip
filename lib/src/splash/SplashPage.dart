import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk/all.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    trySignIn(context);
    return SafeArea(
      child: Container(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  void trySignIn(BuildContext context) async {
    AccessToken token = await AccessTokenStore.instance.fromStore();
    if (token.refreshToken == null) {
      //Navigator.of(context).pushReplacementNamed('/sign_select');
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      print("Access Token: " + token.accessToken);
      Navigator.of(context).pushReplacementNamed('/sign_select');
    }
  }

}