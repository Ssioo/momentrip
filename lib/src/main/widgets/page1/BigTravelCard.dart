import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentrip/src/main/models/MainResponse.dart';

class BigTravelCard extends StatefulWidget {

  final int idx;
  final String name;
  final String date;
  final String city;
  final String imageUrl;

  const BigTravelCard(
      {Key key, this.idx, this.name, this.date, this.city, this.imageUrl})
      : super(key: key);

  @override
  BigTravelCardState createState() =>
      BigTravelCardState(idx, name, date, city, imageUrl);
}

class BigTravelCardState extends State<BigTravelCard> {

  final int idx;
  final String name;
  final String date;
  final String city;
  final String imageUrl;

  BigTravelCardState(this.idx, this.name, this.date, this.city, this.imageUrl);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (idx == -1) {
          return;
        }
        Navigator.pushNamed(context, "/travel", arguments: MainResult(
          tripIdx: idx,
          title: name,
          startedAt: null,
          endedAt: null,
        ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 40),
        color: Color.fromRGBO(24, 23, 23, 1),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.asset(
                "images/img_main_travelcard1.png",
                fit: BoxFit.cover,
              ),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(left: 35, bottom: 20, right: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontFamily: "LemonMilk",
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: Color.fromRGBO(255, 255, 255, 1)
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    city,
                    style: TextStyle(
                        fontFamily: "NotoSansKR",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromRGBO(255, 255, 255, 0.7)
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        fontFamily: "LemonMilk",
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Color.fromRGBO(255, 255, 255, 0.2)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}