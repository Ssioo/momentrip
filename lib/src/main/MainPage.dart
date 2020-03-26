import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';

import './models/MainResponse.dart';
import '../../main.dart';
import 'models/MainParams.dart';
import 'widgets/page1/Page1.dart';
import 'widgets/page3/Page3.dart';


class MainPage extends StatefulWidget  {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {

  int _selectedPageIdx = 0;

  Page1 page1;
  Page3 page3;

  Widget callPage(int idx) {
    switch (idx) {
      case 0:
        if (page1 == null) {
          page1 = Page1();
        }
        return page1;
      case 2:
        if (page3 == null) {
          page3 = Page3();
        }
        return page3;
    }
  }

  // UI Build
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 24, 23, 23),
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        )
    );
    return Scaffold(
      body: Builder(
        builder: (context) {
          return SafeArea(
              child: callPage(_selectedPageIdx)
          );
        },
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "images/icon_home_deactivate.png", width: 32, height: 32,),
                  activeIcon: Image.asset(
                    "images/icon_home_activate.png", width: 32, height: 32,),
                  title: Text('Home')
              ),
              BottomNavigationBarItem(
                icon: Image.asset("images/icon_add_deactivate.png", width: 32,
                  height: 32,
                  color: Color.fromARGB(255, 100, 100, 100),),
                activeIcon: Image.asset(
                  "images/icon_add_activate.png", width: 32, height: 32,),
                title: Text('Add'),
              ),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "images/icon_mypage_deactivate.png", width: 32,
                    height: 32,),
                  activeIcon: Image.asset(
                    "images/icon_mypage_activate.png", width: 32, height: 32,),
                  title: Text('MyPage')
              ),
            ],
            backgroundColor: Colors.black,
            currentIndex: _selectedPageIdx,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.blueGrey,
            iconSize: 32,
            onTap: (idx){
              setState(() {
                if (idx == 1) {
                  tryGetStatus(context);
                } else {
                  _selectedPageIdx = idx;
                }
              });
            },
          );
        },
      ),
    );
  }

  void tryGetStatus(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(
        context, type: ProgressDialogType.Normal, isDismissible: true);
    await progressDialog.show();
    Response response = await MyApp.getDio().get("/tripstatus");
    MainResponse mainResponse = MainResponse.fromJson(response.data);
    await progressDialog.hide();
    if (mainResponse == null || !mainResponse.isSuccess) {
      return;
    }
    switch (mainResponse.code) {
      case 200:
        Navigator.pushNamed(context, "/travel",
            arguments: mainResponse.mainResult.elementAt(0));
        break;
      case 201:
        selectDate(context);
        break;
    }
  }

  void selectDate(BuildContext context) async {
    List<DateTime> pickedDates = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        initialLastDate: DateTime.now().add(Duration(days: 3)),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (pickedDates != null && pickedDates.length == 2) {
      DateTime firstDate = DateTime(
          pickedDates
              .elementAt(0)
              .year, pickedDates
          .elementAt(0)
          .month, pickedDates
          .elementAt(0)
          .day);
      DateTime lastDate = DateTime(
          pickedDates
              .elementAt(0)
              .year, pickedDates
          .elementAt(0)
          .month, pickedDates
          .elementAt(0)
          .day, 23, 59
      );
      tryPostTravel(
          context, firstDate.toIso8601String(), lastDate.toIso8601String());
    }
  }

  void tryPostTravel(BuildContext context, String startTime,
      String endTime) async {
    ProgressDialog progressDialog = ProgressDialog(
        context, type: ProgressDialogType.Normal, isDismissible: true);
    await progressDialog.show();
    Response response = await MyApp.getDio().post(
        "/trip", data: MainParams(startDate: startTime, endDate: endTime));
    MainObjectResponse mainObjectResponse = MainObjectResponse.fromJson(
        response.data);
    await progressDialog.hide();
    if (mainObjectResponse == null || !mainObjectResponse.isSuccess) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "새로운 여행 생성에 실패하였습니다.",
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
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "새로운 여행을 생성하였습니다.",
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
      Scaffold.of(context).hideCurrentSnackBar();
      Navigator.pushNamed(
          context, "/travel", arguments: mainObjectResponse.mainResult);
    });

  }
}