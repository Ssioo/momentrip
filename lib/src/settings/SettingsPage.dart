import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:momentrip/src/main/models/MainResponse.dart';

class SettingsPage extends StatelessWidget {

  MainResult tripSummary;

  @override
  Widget build(BuildContext context) {
    tripSummary = ModalRoute
        .of(context)
        .settings
        .arguments;
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
                              calculateTime(
                                  tripSummary.startedAt, tripSummary.endedAt),
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
                              tripSummary.title == null ? "" : tripSummary
                                  .title,
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

  String calculateTime(String startedAt, String endedAt) {
    int day = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(tripSummary.startedAt)
        .difference(
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(tripSummary.endedAt))
        .inDays;
    print("Day" + day.toString());
    if (day > 0) {
      return day.toString() + "박 " + (day + 1).toString() + "일";
    } else {
      return "당일치기";
    }
  }
}
