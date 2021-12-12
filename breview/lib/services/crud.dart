import 'dart:io';

import 'package:breview/models/UserDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CrudMethods {
  getData(collection) async {
    return FirebaseFirestore.instance.collection(collection).snapshots();
  }

  static void saveUserData(File file, UserDetails userDetails) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("userImg")
        .child(userDetails.firstName + "/" + userDetails.id + ".jpg");
    UploadTask uploadTask;
    uploadTask = reference.putData(await file.readAsBytes());
    String url = await reference.getDownloadURL();
    userDetails.profilePictureUrl = url;
    await uploadTask.whenComplete(() => FirebaseFirestore.instance
        .collection("users")
        .add(userDetails.toMap()));
  }
}
