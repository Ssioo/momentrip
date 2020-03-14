import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 24, 23, 23),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
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
                        decoration: InputDecoration(
                          hintText: "이름을 입력해주세요",
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
                        controller: nameController,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 22, bottom: 15),
                        child: Text(
                          "생년월일",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromARGB(255, 248, 248, 248), fontSize: 16),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "생년월일을 입력해주세요",
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
                        controller: birthController,
                        keyboardType: TextInputType.datetime,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 22, bottom: 15),
                        child: Text(
                          "이메일",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromARGB(255, 248, 248, 248), fontSize: 16),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "이메일을 입력해주세요",
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 22, bottom: 15),
                        child: Text(
                          "비밀번호",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromARGB(255, 248, 248, 248), fontSize: 16),
                        ),
                      ),
                      TextFormField(
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
              ),
              MaterialButton(
                child: Text(
                  "가입 완료",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  trySignUp(nameController.text, birthController.text, emailController.text, passwordController.text);
                },
                minWidth: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 255, 77, 32),
                padding: EdgeInsets.only(top: 19, bottom: 19),
              )
            ],
          )
      ),
    );
  }

  void trySignUp(String name, String birth, String email, String password) {
    final SignUpService signUpService = SignUpService(this);
  }

  @override
  validateFailure() {
    // TODO: implement validateFailure
    throw UnimplementedError();
  }

  @override
  validateSuccess() {
    Navigator.pop(context);
  }

}
