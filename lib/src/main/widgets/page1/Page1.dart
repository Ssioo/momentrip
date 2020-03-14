import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'BigTravelCard.dart';

class Page1 extends StatefulWidget {
  @override
  Page1State createState() => Page1State();
}

class Page1State extends State<Page1> {
  int totalPage = 5;
  int curPageIdx = 0;
  double page = 2.0;
  PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController =
        PageController(initialPage: curPageIdx, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 24, 23, 23),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 84),
              child: Row(children: <Widget>[
                Expanded(
                  child: Text(
                    '2019',
                    style: TextStyle(
                        color: Color.fromARGB(255, 150, 150, 150),
                        fontSize: 28,
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  '최근순',
                  style: TextStyle(
                      color: Color.fromARGB(255, 150, 150, 150),
                      fontSize: 12,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w300),
                ),
              ]),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    setState(() {
                      page = pageController.page;
                    });
                  }
                  return true;
                },
                child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (pos) {
                      setState(() {
                        curPageIdx = pos;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: totalPage,
                    itemBuilder: (context, index) {
                      return BigTravelCard();
                    }),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 35, bottom: 35, left: 20, right: 20),
              child: SmoothPageIndicator(
                controller: pageController,
                count: totalPage,
                effect: SlideEffect(
                    spacing: 0.0,
                    radius: 0.0,
                    dotWidth: (MediaQuery.of(context).size.width - 40) /
                        totalPage.toDouble(),
                    dotHeight: 2.0,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Color.fromARGB(255, 64, 64, 63),
                    activeDotColor: Color.fromARGB(255, 255, 255, 255)),
              ),
            )
          ],
        ));
  }
}
