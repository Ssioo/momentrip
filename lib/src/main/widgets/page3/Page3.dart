import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../main.dart';
import 'models/Page3Response.dart';

class Page3 extends StatefulWidget {
  @override
  Page3State createState() => Page3State();
}

class Page3State extends State<Page3> {
  Page3Result myPageResult;

  @override
  void initState() {
    super.initState();
    tryGetMyPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(24, 23, 23, 1),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Image.asset(
                    "images/img_mypage_airplane.png",
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 27, right: 60),
                    child: Container(
                      color: Color.fromRGBO(255, 77, 32, 1),
                      child: Padding(
                        padding: EdgeInsets.only(top: 28, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "횟수",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "NotoSansKR",
                                        fontSize: 12,
                                        color: Color.fromRGBO(255, 255, 255, 0.6)
                                    ),
                                  ),
                                  Text(
                                    myPageResult == null ? "-" : myPageResult.tripCount.toString(),
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: "Kenyan",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Color.fromRGBO(207, 207, 207, 0.4),
                              thickness: 1,
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "국가",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "NotoSansKR",
                                        fontSize: 12,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.6)),
                                  ),
                                  Text(
                                    myPageResult == null
                                        ? "-"
                                        : myPageResult.countryCount.toString(),
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: "Kenyan",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Color.fromRGBO(207, 207, 207, 0.4),
                              thickness: 1,
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "도시",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "NotoSansKR",
                                        fontSize: 12,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.6)),
                                  ),
                                  Text(
                                    myPageResult == null
                                        ? "-"
                                        : myPageResult.cityCount.toString(),
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: "Kenyan",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 9,
                padding: EdgeInsets.only(top: 48, bottom: 24, left: 30, right: 30),
                itemBuilder: (context, index) {
                  return IconButton(
                    icon: Icon(Icons.map),
                    onPressed: () {

                    },
                    iconSize: 48,
                    color: Color.fromRGBO(100, 100, 100, 1),
                  );
                },
              ),
            ),
          ),
          SliverList(
           delegate: SliverChildListDelegate(
             [
               SizedBox(
                 height: 60,
                 child: Container(
                   color: Color.fromRGBO(24, 23, 23, 1),
                 ),
               )
             ]
           ),
          ),
          SliverStaggeredGrid.countBuilder(
              crossAxisCount: 4,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/momentrip-32cf2.appspot.com/o/mypage_04.png?alt=media&token=49288536-92fd-4bd1-9007-004548736f19",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ],
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(2, index.isEven ? 3 : 2);
              },
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          )
        ],
      ),
    );
  }

  void tryGetMyPage(BuildContext buildContext) async {
    Response response = await MyApp.getDio().get("/mypage");
    Page3Response page3Response = Page3Response.fromJson(response.data);
    if (page3Response == null || !page3Response.isSuccess) {
      return;
    }
    setState(() {
      myPageResult = page3Response.result;
    });
  }

}
