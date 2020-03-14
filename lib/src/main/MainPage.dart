import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter/services.dart';

import 'MainService.dart';
import 'interfaces/MainView.dart';
import 'package:flutter/material.dart';
import 'models/MainResponse.dart';
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
        child: callPage(_selectedPageIdx)
      ),
      bottomNavigationBar: BottomNavigationBar(
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
              //selectDate();
              Navigator.pushNamed(context, "/travel");
            } else {
              _selectedPageIdx = idx;
            }
          });
        },
      ),
    );
  }

  @override
  void validateFailure() {

  }

  @override
  void validateSuccess(MainResponse mainResponse) {

  }

  void tryPostTravel() {
    final MainService mMainService = MainService(this);
    mMainService.getTest();
  }

  Future<List<DateTime>> selectDate() async {
    List<DateTime> pickedDates = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        initialLastDate: DateTime.now().add(Duration(days: 3)),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (pickedDates != null && pickedDates.length == 2) {
      return pickedDates;
    } else {
      return null;
    }
  }
}