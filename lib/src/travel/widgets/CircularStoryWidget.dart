import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularStroyWidget extends StatelessWidget {

  final int day;
  final String thumbnailUrl;

  const CircularStroyWidget({Key key, this.day, this.thumbnailUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 80,
          child: InkWell(
            onTap: () {

            },
            highlightColor: Color.fromRGBO(255, 255, 255, 0.38),
            child: Card(
              margin: EdgeInsets.only(left: 9, right: 9),
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: CircleBorder(
                side: BorderSide(
                    color: Color.fromARGB(255, 255, 99, 62),
                    width: 2),
              ),
              child: Image.network(
                thumbnailUrl,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ),
            ),
          ),
        ),
        Text(
          "DAY " + day.toString(),
          style: TextStyle(
            color: Color.fromARGB(255, 142, 142, 142),
            fontFamily: "NotoSansKR",
            fontWeight: FontWeight.w300,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
