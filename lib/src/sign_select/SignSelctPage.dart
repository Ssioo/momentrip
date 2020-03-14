import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';

class SignSelectPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("images/img_travelcard.png", fit: BoxFit.cover,),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: MaterialButton(
                  child: Text(
                    "이메일로 가입하기",
                    style: TextStyle(
                        color: Color.fromARGB(255, 248, 248, 248),
                        fontSize: 14,
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w300
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                      side: BorderSide(
                          color: Color.fromARGB(255, 151, 151, 151),
                          style: BorderStyle.solid,
                          width: 1.0
                      )
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign_up');
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  height: 46,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 12),
                  child: MaterialButton(
                    child: Text(
                      "카카오톡으로 로그인하기",
                      style: TextStyle(
                          color: Color.fromARGB(255, 24, 23, 23),
                          fontSize: 14,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    onPressed: kakaoLoginViaBrowser,
                    height: 46,
                    minWidth: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 250, 223, 1),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 48),
                child: Text(
                  "계정이 있나요?",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.45),
                      fontSize: 14,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w300
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 69),
                child: MaterialButton(
                  child: Text(
                    "로그인",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 14,
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w300
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign_in");
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void kakaoLoginViaBrowser() async {
    try {
      String authCode = await AuthCodeClient.instance.request();
      AccessTokenResponse accessTokenResponse = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(accessTokenResponse);
    } on KakaoAuthException catch (e) {

    } on KakaoClientException catch(e) {

    }
    catch (e) {

    }
  }

  void kakaoLoginViaTalk() async {
    try {
      String authCode = await AuthCodeClient.instance.requestWithTalk();
      AccessTokenResponse accessTokenResponse = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(accessTokenResponse);
    } on KakaoAuthException catch (e) {

    } on KakaoClientException catch (e) {

    } catch (e) {

    }
  }

}