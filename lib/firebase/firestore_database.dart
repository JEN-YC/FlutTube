import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttube/home/comment_widget.dart';

StreamBuilder<QuerySnapshot> getComments(String movieId) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('comments')
        .where("movie_id", isEqualTo: movieId)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );
      final int commentCount = snapshot.data.documents.length;
      snapshot.data.documents
          .sort((a, b) => b.data['time'].compareTo(a.data['time']));
      if (commentCount > 0) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: commentCount,
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            return commentWidget(
              document['user_email'],
              document['content'],
              document['time'],
            );
          },
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          child: Text(
            'no comments...',
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    },
  );
}

void createRecord(String movieId, String email, String content) async {
  await Firestore.instance.collection("comments").document().setData({
    'movie_id': movieId,
    'user_email': email,
    'content': content,
    'time': Timestamp.now()
  });
}

Future<String> getProfilePictureUrl(String email) async {
  var doc = await Firestore.instance.collection('Users').document(email).get();
  if (doc.exists) {
    return doc.data['profile_picture_url'];
  }
  return '';
}

void updateProfilePictureUrl(String email, String url) async {
  print(url);
  await Firestore.instance.collection("Users").document(email).setData({
    'profile_picture_url': url,
  }, merge: true);
}

void updateUserToken(String email, String token) async {
  await Firestore.instance.collection("Users").document(email).setData({
    'fcm_token': token,
  }, merge: true);
}
