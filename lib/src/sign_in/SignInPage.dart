import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momentrip/main.dart';
import 'package:momentrip/src/sign_in/models/SignInResponse.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'models/SignInParams.dart';

class SignInPage extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 33, 33, 32),
          centerTitle: true,
          title: Text(
            "로그인",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "NotoSansKR",
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
        ),
        body: Builder(
          builder: (context) {
            return Container(
              color: Color.fromARGB(255, 24, 24, 23),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 82),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 105, bottom: 15),
                                  child: Text(
                                    "이메일",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 248, 248, 248),
                                        fontSize: 16,
                                        fontFamily: "NotoSansKR",
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "NotoSansKR",
                                      fontWeight: FontWeight.w300),
                                  focusNode: emailFocusNode,
                                  onFieldSubmitted: (value) {
                                    emailFocusNode.unfocus();
                                    passwordFocusNode.requestFocus();
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: "이메일을 입력해주세요",
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.4),
                                        fontSize: 16,
                                        fontFamily: "NotoSansKR",
                                        fontWeight: FontWeight.w300),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(84, 84, 84, 1),
                                          style: BorderStyle.solid,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                    ),
                                    fillColor:
                                        Color.fromRGBO(255, 255, 255, 0.04),
                                    filled: true,
                                  ),
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 22, bottom: 15),
                                  child: Text(
                                    "비밀번호",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 248, 248, 248),
                                        fontSize: 16,
                                        fontFamily: "NotoSansKR",
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "NotoSansKR",
                                      fontWeight: FontWeight.w300),
                                  focusNode: passwordFocusNode,
                                  onFieldSubmitted: (value) {
                                    passwordFocusNode.unfocus();
                                  },
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "비밀번호을 입력해주세요",
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.4),
                                        fontSize: 16,
                                        fontFamily: "NotoSansKR",
                                        fontWeight: FontWeight.w300),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(84, 84, 84, 1),
                                          style: BorderStyle.solid,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                    ),
                                    fillColor:
                                        Color.fromRGBO(255, 255, 255, 0.04),
                                    filled: true,
                                  ),
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      child: Text(
                        "로그인",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontFamily: "NotoSansKR",
                            fontWeight: FontWeight.w400),
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "입력되지 않은 값이 있습니다.",
                              style: TextStyle(
                                  fontFamily: "NotoSansKR",
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 248, 248, 2)),
                            ),
                            action: SnackBarAction(
                              label: "닫기",
                              onPressed: () {
                                Scaffold.of(context).hideCurrentSnackBar();
                              },
                            ),
                          ));
                          return;
                        }
                        RegExp emailReg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (!emailReg.hasMatch(emailController.text)) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "이메일 형식을 확인해주세요.",
                              style: TextStyle(
                                  fontFamily: "NotoSansKR",
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 248, 248, 2)),
                            ),
                            action: SnackBarAction(
                              label: "닫기",
                              onPressed: () {
                                Scaffold.of(context).hideCurrentSnackBar();
                              },
                            ),
                          ));
                          return;
                        }
                        trySignIn(context, emailController.text, passwordController.text);
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 255, 77, 32),
                      padding: EdgeInsets.only(top: 19, bottom: 19),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  void trySignIn(BuildContext context, String email, String password) async {
    ProgressDialog dialog;
    dialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    try {
      await dialog.show();
      Response response = await MyApp.getDio().post("/signIn", data: SignInParams(userEmail: email, userPw: password).toJson());
      SignInResponse signInResponse = SignInResponse.fromJson(response.data);
      if (signInResponse == null) {
        throw Exception();
      }
      await dialog.hide();
      switch (signInResponse.code) {
        case 200:
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              "환영합니다.",
              style: TextStyle(
                  fontFamily: "NotoSansKR",
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 248, 248, 2)),
            ),
            action: SnackBarAction(
              label: "닫기",
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
              },
            ),
          ));
          Future.delayed(Duration(milliseconds: 500), () {
            MyApp.sSharedPreferences
                .setString(MyApp.X_ACCESS_TOKEN, signInResponse.result.token)
                .then((value) {
              MyApp.sSharedPreferences
                  .setString(MyApp.LOGIN_TYPE, MyApp.LOGIN_TYPE_NORMAL)
                  .then((value) {
                Navigator.pushReplacementNamed(context, "/main");
              });
            }); // 토큰 저장.
          });
          break;
        case 301:
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              "입력되지 않은 값이 있습니다.",
              style: TextStyle(
                  fontFamily: "NotoSansKR",
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 248, 248, 2)),
            ),
            action: SnackBarAction(
              label: "닫기",
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
              },
            ),
          ));
          break;
        case 302:
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              "이메일과 비밀번호를 확인해주세요.",
              style: TextStyle(
                  fontFamily: "NotoSansKR",
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 248, 248, 2)),
            ),
            action: SnackBarAction(
              label: "닫기",
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
              },
            ),
          ));
          break;
        default:
          throw Exception();
          break;
      }
    } catch (e) {
      await dialog.hide();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "로그인에 실패하였습니다.",
          style: TextStyle(
              fontFamily: "NotoSansKR",
              fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 248, 248, 2)),
        ),
        action: SnackBarAction(
          label: "닫기",
          onPressed: () {
            Scaffold.of(context).hideCurrentSnackBar();
          },
        ),
      ));
    }
  }
}
