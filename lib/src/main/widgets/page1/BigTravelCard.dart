import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigTravelCard extends StatefulWidget {

  final String name;
  final String date;
  final String city;
  final String imageUrl;

  const BigTravelCard({Key key, this.name, this.date, this.city, this.imageUrl}) : super(key: key);

  @override
  BigTravelCardState createState() => BigTravelCardState(name, date, city, imageUrl);
}

class BigTravelCardState extends State<BigTravelCard> {

  final String name;
  final String date;
  final String city;
  final String imageUrl;

  BigTravelCardState(this.name, this.date, this.city, this.imageUrl);


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 40),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        color: Color.fromRGBO(24, 23, 23, 1),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset(
                "images/img_main_travelcard1.png",
                fit: BoxFit.cover,
              ),
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
                        fontFamily: "Kenyan",
                        fontSize: 40,
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
                        fontFamily: "NotoSansKR",
                        fontWeight: FontWeight.w500,
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