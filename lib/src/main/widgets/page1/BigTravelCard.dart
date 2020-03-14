import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigTravelCard extends StatefulWidget {
  @override
  BigTravelCardState createState() => BigTravelCardState();
}

class BigTravelCardState extends State<BigTravelCard> {

  var imageUrl = "images/img_travelcard.png";

  @override
  Widget build(BuildContext context) {
    return SlidingCard(
      name: "HONGKONG",
      date: "19.01.28~19.02.05",
      imageUrl: "images/img_travelcard.png",
    );
  }

}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String imageUrl;

  SlidingCard({this.name, this.date, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 40),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }}