import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentrip/src/common/models/DefaultResponse.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'SignUpService.dart';
import 'interfaces/SignUpView.dart';

class SignUpPage extends StatefulWidget {

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> implements SignUpView {

  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final nameFocusNode = FocusNode();
  final birthFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "가입하기",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 33, 32, 32),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Builder(
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Color.fromARGB(255, 24, 23, 23),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 82),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 48, bottom: 15),
                                child: Text(
                                  "이름",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 248, 248, 248), fontSize: 16),
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "NotoSansKR",
                                    fontWeight: FontWeight.w300
                                ),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  nameFocusNode.unfocus();
                                  birthFocusNode.requestFocus();
                                },
                                focusNode: nameFocusNode,
                                decoration: InputDecoration(
                                  hintText: "이름을 입력해주세요",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.4),
                                      fontSize: 16,
                                      fontFamily: "NotoSansKR",
                                      fontWeight: FontWeight.w300
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(84, 84, 84, 1),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(255, 255, 255, 0.4),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  fillColor: Color.fromRGBO(255, 255, 255, 0.04),
                                  filled: true,
                                ),
                                controller: nameController,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 22, bottom: 15),
                                child: Text(
                                  "생년월일",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 248, 248, 248),
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
                                    fontWeight: FontWeight.w300
                                ),
                                onFieldSubmitted: (value) {
                                  birthFocusNode.unfocus();
                                  emailFocusNode.requestFocus();
                                },
                                focusNode: birthFocusNode,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: "생년월일을 입력해주세요",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.4),
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
                                        color: Color.fromRGBO(255, 255, 255, 0.4),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  fillColor: Color.fromRGBO(255, 255, 255, 0.04),
                                  filled: true,
                                ),
                                controller: birthController,
                                keyboardType: TextInputType.datetime,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 22, bottom: 15),
                                child: Text(
                                  "이메일",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 248, 248, 248),
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
                                    fontWeight: FontWeight.w300
                                ),
                                onFieldSubmitted: (value) {
                                  emailFocusNode.unfocus();
                                  passwordFocusNode.requestFocus();
                                },
                                focusNode: emailFocusNode,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: "이메일을 입력해주세요",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.4),
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
                                        color: Color.fromRGBO(255, 255, 255, 0.4),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  fillColor: Color.fromRGBO(255, 255, 255, 0.04),
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
                                      color: Color.fromARGB(255, 248, 248, 248),
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
                                    fontWeight: FontWeight.w300
                                ),
                                onFieldSubmitted: (value) {
                                  passwordFocusNode.unfocus();
                                },
                                focusNode: passwordFocusNode,
                                decoration: InputDecoration(
                                  hintText: "비밀번호를 입력해주세요",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.4),
                                      fontSize: 16),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(84, 84, 84, 1),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(255, 255, 255, 0.4),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  fillColor: Color.fromRGBO(255, 255, 255, 0.04),
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
                      "가입 완료",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontFamily: "NotoSansKR",
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    onPressed: () {
                      if (nameController.text.isEmpty || birthController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "입력되지 않은 값이 있습니다.",
                            style: TextStyle(
                                fontFamily: "NotoSansKR",
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 248, 248, 2)
                            ),
                          ),
                            action: SnackBarAction(
                              label: "닫기",
                              onPressed: () {
                                Scaffold.of(context).hideCurrentSnackBar();
                              },
                        )));
                        return;
                      }
                      trySignUp(context, nameController.text, birthController.text, emailController.text, passwordController.text);
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
      )
    );
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

  void trySignUp(BuildContext context, String name, String birth, String email, String password) {
    showProgressDialog(context);
    FocusScope.of(context).requestFocus(FocusNode());
    final SignUpService signUpService = SignUpService(this);
    signUpService.postUser(context, name, birth, email, password);
  }

  @override
  validateFailure(BuildContext context) {
    hideProgressDialog(context);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "회원가입에 실패하였습니다.",
        style: TextStyle(
            fontFamily: "NotoSansKR",
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(255, 248, 248, 2)
        ),
      ),
        action: SnackBarAction(
          label: "닫기",
          onPressed: () {
            Scaffold.of(context).hideCurrentSnackBar();
          },
    )));
  }

  @override
  validateSuccess(BuildContext context, DefaultResponse response) {
    hideProgressDialog(context);
    switch (response.code) {
      case 201:
        // 회원가입 성공
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "회원가입에 성공하였습니다.",
            style: TextStyle(
                fontFamily: "NotoSansKR",
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 248, 248, 2)
            ),
          ),
          action: SnackBarAction(
            label: "닫기",
            onPressed: () {
              Scaffold.of(context).hideCurrentSnackBar();
            },
          ),
        ));
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
        break;
      case 302:
        // 아이디 중복
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "중복된 아이디가 존재합니다.",
            style: TextStyle(
                fontFamily: "NotoSansKR",
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 248, 248, 2)
            ),
          ),
          action: SnackBarAction(
            label: "닫기",
            onPressed: () {
              Scaffold.of(context).hideCurrentSnackBar();
            },
          ),
        ));
        break;
    }
  }

}
