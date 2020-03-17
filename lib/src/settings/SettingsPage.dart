import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(33, 32, 32, 1),
        title: Text(
          "설정",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: "NotoSansKR",
            fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: Container(
              color: Color.fromRGBO(24, 23, 23, 1),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 32,
                  ),
                  FlatButton(
                    color: Color.fromRGBO(33, 32, 32, 1),
                    padding: EdgeInsets.only(left: 30, top: 14, bottom: 14, right: 30),
                    textColor: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "전체 삭제",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "NotoSansKR",
                          fontWeight: FontWeight.w300,
                          fontSize: 16
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    onPressed: () {

                    },
                  ),
                  SizedBox(
                    height: 83,
                  ),
                  FlatButton(
                    color: Color.fromRGBO(33, 32, 32, 1),
                    padding: EdgeInsets.only(left: 30, top: 14, bottom: 14, right: 30),
                    textColor: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "여행 삭제",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "NotoSansKR",
                            fontWeight: FontWeight.w300,
                            fontSize: 16
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    onPressed: () {

                    },
                  ),
                  Container(
                    color: Color.fromRGBO(33, 32, 32, 1),
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Container(
                        height: 1,
                        color: Color.fromRGBO(151, 151, 151, 0.2),
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Color.fromRGBO(33, 32, 32, 1),
                    padding: EdgeInsets.only(left: 30, top: 14, bottom: 14, right: 30),
                    textColor: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          Text(
                            "여행기간 수정",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "NotoSansKR",
                                fontWeight: FontWeight.w300,
                                fontSize: 16
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "7박 8일",
                              style: TextStyle(
                                color: Color.fromRGBO(248, 248, 248, 0.4),
                                fontSize: 16,
                                fontFamily: "NotoSansKR",
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {

                    },
                  ),
                  SizedBox(
                    height: 61,
                  ),
                  FlatButton(
                    color: Color.fromRGBO(33, 32, 32, 1),
                    padding: EdgeInsets.only(left: 30, top: 14, bottom: 14, right: 30),
                    textColor: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          Text(
                            "제목 수정",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "NotoSansKR",
                                fontWeight: FontWeight.w300,
                                fontSize: 16
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "SPAIN",
                              style: TextStyle(
                                  color: Color.fromRGBO(248, 248, 248, 0.4),
                                  fontSize: 16,
                                  fontFamily: "NotoSansKR",
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
