import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentrip/src/main/widgets/page1/models/Page1Response.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../main.dart';
import 'BigTravelCard.dart';

class Page1 extends StatefulWidget {
  @override
  Page1State createState() => Page1State();
}

class Page1State extends State<Page1> {
  int curPageIdx = 0;
  double page = 2.0;
  PageController pageController;

  List<Page1Result> tripResults;
  Page1Result defaultTrip = Page1Result(
      tripImgUrl: "https://firebasestorage.googleapis.com/v0/b/momentrip-32cf2.appspot.com/o/home_01.png?alt=media&token=94836d9e-b84d-442f-b718-421562c1964d",
      city: "To the new world",
      date: "RIGHT NOW",
      title: "GO ABROAD!",
      tripIdx: -1,
      year: "2020",
      country: "Go Abroad!");

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: curPageIdx, viewportFraction: 0.8);
    tryGetTrips();
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
                    DateTime
                        .now()
                        .year
                        .toString(),
                    style: TextStyle(
                        color: Color.fromARGB(255, 150, 150, 150),
                        fontSize: 28,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'LemonMilk',),
                  ),
                ),
                MaterialButton(
                  onPressed: () {

                  },
                  child: Text(
                    '최근순',
                    style: TextStyle(
                        color: Color.fromARGB(255, 150, 150, 150),
                        fontSize: 12,
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Builder(
                  builder: (context) {
                    if (tripResults == null || tripResults.length == 0) {
                      return BigTravelCard(
                        idx: defaultTrip.tripIdx,
                        name: defaultTrip.title,
                        imageUrl: defaultTrip.tripImgUrl,
                        city: defaultTrip.city,
                        date: defaultTrip.date,
                      );
                    }
                    return NotificationListener<ScrollNotification>(
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
                          itemCount: tripResults.length,
                          itemBuilder: (context, index) {
                            return BigTravelCard(
                              idx: tripResults
                                  .elementAt(index)
                                  .tripIdx,
                              name: tripResults
                                  .elementAt(index)
                                  .title,
                              imageUrl: tripResults
                                  .elementAt(index)
                                  .tripImgUrl,
                              city: tripResults
                                  .elementAt(index)
                                  .city,
                              date: tripResults
                                  .elementAt(index)
                                  .date,
                            );
                          }),
                    );
                  }),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 35, bottom: 35, left: 20, right: 20),
              child: SmoothPageIndicator(
                controller: pageController,
                count: tripResults == null || tripResults.length == 0 ? 1 : tripResults.length,
                effect: SlideEffect(
                    spacing: 0.0,
                    radius: 0.0,
                    dotWidth: (MediaQuery.of(context).size.width - 40) / (tripResults == null || tripResults.length == 0 ? 1 : tripResults.length.toDouble()),
                    dotHeight: 2.0,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Color.fromARGB(255, 64, 64, 63),
                    activeDotColor: Color.fromARGB(255, 255, 255, 255)),
              ),
            )
          ],
        ));
  }

  void tryGetTrips() async {
    Response response = await MyApp.getDio().get("/alltrip");
    Page1Response page1response = Page1Response.fromJson(response.data);
    if (page1response == null) {
      return;
    }
    setState(() {
      tripResults = page1response.result;
    });
  }
}
