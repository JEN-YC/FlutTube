import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget commentWidget(String email, String content, var time) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Colors.black,
        width: 3.0,
      ))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                email,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                timeago.format(time.toDate()),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            alignment: Alignment.topLeft,
            child: Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ));
}
