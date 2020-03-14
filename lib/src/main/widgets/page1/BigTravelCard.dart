import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigTravelCard extends StatefulWidget {
  @override
  BigTravelCardState createState() => BigTravelCardState();
}

class BigTravelCardState extends State<BigTravelCard> {

  @override
  Widget build(BuildContext context) {
    return SlidingCard(
      name: "SPAIN",
      date: "19.03.28~19.04.16",
      imageUrl: "https://firebasestorage.googleapis.com/v0/b/momentrip-32cf2.appspot.com/o/home_02.png?alt=media&token=27716801-9eb0-49e1-9c47-477faf9400b0",
      city: "바르셀로나 세비야 톨레드 마드리드",
    );
  }

}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String city;
  final String imageUrl;

  SlidingCard({this.name, this.date, this.imageUrl, this.city});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 40),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(left: 35, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontFamily: "NotoSansKR",
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                      color: Color.fromARGB(255, 255, 255, 255)
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
                      color: Color.fromARGB(255, 255, 255, 255)
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  date,
                  style: TextStyle(
                      fontFamily: "NotoSansKR",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color.fromARGB(255, 255, 255, 255)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }}