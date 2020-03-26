import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPageTravelCard extends StatefulWidget {
  final String thumbnail;
  final String country;
  final String city;
  final int day;
  final String date;
  final int videoIdx;
  final String videoUrl;

  const MyPageTravelCard(
      {Key key,
      this.thumbnail,
      this.country,
      this.city,
      this.day,
      this.date,
      this.videoIdx,
      this.videoUrl})
      : super(key: key);

  @override
  MyPageTravelState createState() => MyPageTravelState(
      thumbnail, country, city, day, date, videoIdx, videoUrl);
}

class MyPageTravelState extends State<MyPageTravelCard> {
  final String thumbnail;
  final String country;
  final String city;
  final int day;
  final String date;
  final int videoIdx;
  final String videoUrl;

  MyPageTravelState(this.thumbnail, this.country, this.city, this.day,
      this.date, this.videoIdx, this.videoUrl);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/momentrip-32cf2.appspot.com/o/mypage_04.png?alt=media&token=49288536-92fd-4bd1-9007-004548736f19",
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            children: <Widget>[
              Text(
                country,
                style: TextStyle(
                  fontFamily: "LemonMilk",
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                city,
                style: TextStyle(
                  fontFamily: "NotoSansKR",
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    day.toString() + "DAY",
                    style: TextStyle(
                      fontFamily: "LemonMilk",
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  Text(date)
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
