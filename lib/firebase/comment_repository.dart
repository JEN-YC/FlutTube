import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentRepository {
  final Firestore _firestore;

  CommentRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  StreamBuilder<QuerySnapshot> getComments(String movieId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('comments')
          .where("movie_id", isEqualTo: movieId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return const Text('There is no comment right now.');
        final int commentCount = snapshot.data.documents.length;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: commentCount,
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            return CommentWidget(
              document['user_email'],
              document['content'],
              document['time'],
            );
          },
        );
      },
    );
  }
}

class CommentWidget extends StatelessWidget {
  String _email;
  String _content;
  String _time;
  CommentWidget(this._email, this._content, this._time);

  @override
  Widget build(BuildContext context) {

  }
}
