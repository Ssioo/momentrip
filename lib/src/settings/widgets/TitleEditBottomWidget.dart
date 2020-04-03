import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleEditBottomWidget extends StatefulWidget {

  final String title;

  const TitleEditBottomWidget({Key key, this.title}) : super(key: key);

  @override
  TitleEditBottomState createState() => TitleEditBottomState(title);
}

class TitleEditBottomState extends State<TitleEditBottomWidget> {

  final String title;

  TextEditingController titleController;
  FocusNode titleNode;

  TitleEditBottomState(this.title);

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    titleNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "제목 수정",
                  style: TextStyle(
                    fontFamily: "NotoSansKR",
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 16
                  ),
                ),
              ), Align(
                alignment: Alignment.topRight,
                child: MaterialButton(
                  onPressed: () {

                  },
                  child: Text(
                    "완료",
                    style: TextStyle(
                        fontFamily: "NotoSansKR",
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(168, 168, 168, 1),
                        fontSize: 14
                    ),
                  ),
                ),
              )
            ],
          ),
          TextFormField(
            controller: titleController,
            focusNode: titleNode,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: "LemonMilk",
              color: Colors.black,
              fontStyle: FontStyle.italic
            ),
            decoration: InputDecoration(
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(216, 216, 216, 1)
                ),
              ),
            ),
            initialValue: title,
          )
        ],
      ),
    );
  }
}