import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyCircularStoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      spacing: 3,
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          padding: EdgeInsets.all(6),
          child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(40),
              child: Container(
                color: Color.fromRGBO(216, 216, 216, 0.14),
              )),
        ),
        Text(
          "",
          style: TextStyle(
            color: Color.fromARGB(255, 142, 142, 142),
            fontFamily: "LemonMilk",
            fontWeight: FontWeight.w300,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
