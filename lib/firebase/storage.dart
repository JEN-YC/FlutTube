import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:flutter/material.dart';

StorageUploadTask uploadImage(File image, String email) {
  final extension = p.extension(image.path);
  final StorageReference ref =
      FirebaseStorage(storageBucket: 'gs://fluttube-97b64.appspot.com')
          .ref()
          .child('$email$extension');
  final StorageUploadTask uploadTask = ref.putFile(image);
  return uploadTask;
}

Future<String> userSticker(String email) async {
  final Future<StorageReference> ref = FirebaseStorage.instance
      .getReferenceFromUrl(
          'gs://fluttube-97b64.appspot.com/test123@yahoo.com.tw.jpg');
  var url = await ref.then((file) => file.getDownloadURL());
  return url;
}
