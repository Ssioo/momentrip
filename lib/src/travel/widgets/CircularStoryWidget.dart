import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:momentrip/src/travel/models/TravelResponse.dart';

class CircularStoryWidget extends StatelessWidget {

  final String startedAt;
  final List<TravelResult> travelResultInDay;

  const CircularStoryWidget({Key key, this.travelResultInDay, this.startedAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
            "/travel/story", arguments: travelResultInDay);
      },
      child: Wrap(
        spacing: 3,
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Stack(
              children: <Widget>[
                Container(
                  width: 72,
                  height: 72,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 255, 99, 62)),
                    backgroundColor: Color.fromRGBO(142, 142, 142, 1),
                    strokeWidth: 2,
                    value: getProgressValue(startedAt, travelResultInDay
                        .elementAt(0)
                        .day),
                  ),
                ),
                Container(
                  width: 72,
                  height: 72,
                  padding: EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                        imageUrl: travelResultInDay
                            .elementAt(0)
                            .thumbnailUrl,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator(),),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error),)
                    ),
                  ),
                ),
              ]
          ),
          Text(
            travelResultInDay
                .elementAt(0)
                .day
                .toString() + " DAY",
            style: TextStyle(
              color: Color.fromARGB(255, 142, 142, 142),
              fontFamily: "LemonMilk",
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  double getProgressValue(String startedAt, int day) {
    if (startedAt == null) {
      return 1.0;
    }
    DateTime startDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z").parse(
        startedAt);
    DateTime curLastDate = startDate.add(Duration(days: day - 1));
    DateTime curDate = DateTime.now();
    if (curLastDate.day == curDate.day) {
      int leftTime = curDate
          .difference(curLastDate)
          .inMinutes;
      return leftTime / 1440.toDouble();
    } else if (curLastDate.day < curDate.day) {
      return 1.0;
    } else {
      return 0.0;
    }
  }
}
