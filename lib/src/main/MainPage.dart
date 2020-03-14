import 'dart:math';

import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'MainService.dart';
import 'interfaces/MainView.dart';
import 'package:flutter/material.dart';
import '../common/models/DefaultResponse.dart';
import 'widgets/page2/Page2.dart';
import 'widgets/page1/Page1.dart';
import 'widgets/page3/Page3.dart';


class MainPage extends StatefulWidget  {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> implements MainView{

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
      body: SafeArea(
        child: callPage(_selectedPageIdx),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_array),
                  title: Text('Home')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                title: Text('Add'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
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
                  selectDate(context);
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

  ProgressDialog dialog;
  showProgressDialog(BuildContext context) async {
    if (dialog == null) {
      dialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true);
    }
    await dialog.show();
  }
  hideProgressDialog(BuildContext context) async {
    if (dialog != null && dialog.isShowing()) {
      dialog.hide();
    }
  }


  void tryPostTravel(BuildContext context, String startTime, String endTime) {
    showProgressDialog(context);
    final MainService mMainService = MainService(this);
    mMainService.postTrip(context, startTime, endTime);
  }

  void selectDate(BuildContext context) async {
    List<DateTime> pickedDates = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        initialLastDate: DateTime.now().add(Duration(days: 3)),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (pickedDates != null && pickedDates.length == 2) {
      tryPostTravel(context, pickedDates.elementAt(0).toIso8601String(), pickedDates.elementAt(1).toIso8601String());
    }
  }

  @override
  void validateFailure(BuildContext buildContext) {
    hideProgressDialog(buildContext);
    Scaffold.of(buildContext).showSnackBar(SnackBar(
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
          Scaffold.of(buildContext).hideCurrentSnackBar();
        },
      ),
    ));
  }

  @override
  void validateSuccess(BuildContext buildContext, DefaultResponse defaultResponse) {
    hideProgressDialog(buildContext);
    Scaffold.of(buildContext).showSnackBar(SnackBar(
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
          Scaffold.of(buildContext).hideCurrentSnackBar();
        },
      ),
    ));
    Future.delayed(Duration(milliseconds: 500), () {
      Scaffold.of(buildContext).hideCurrentSnackBar();
      Navigator.pushNamed(context, "/travel");
    });

  }
}