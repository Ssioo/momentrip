import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  @override
  Page2State createState() => Page2State();
}

class Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          height: 512,
          width: MediaQuery.of(context).size.width,
          child: Container(
            color: Color.fromARGB(255, 245, 243, 243),
          ),
        )
    );
  }
}
