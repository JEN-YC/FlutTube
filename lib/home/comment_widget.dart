import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../firebase/firestore_database.dart';

Widget commentWidget(String email, String content, var time) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Colors.black,
        width: 3.0,
      ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            child: FutureBuilder<String>(
              future: getProfilePictureUrl(email),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.done:
                    if (snapshot.data.isEmpty)
                      return Image.asset(
                        'assets/no.jpg',
                        fit: BoxFit.fill,
                      );
                    return Image.network(
                      snapshot.data,
                      fit: BoxFit.fill,
                    );
                }
                return null;
              },
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    email,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    timeago.format(time.toDate()),
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300, maxHeight: 1000),
                child: Container(
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}
