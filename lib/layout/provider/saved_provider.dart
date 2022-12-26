import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/saved_model.dart';

class SavedProvider with ChangeNotifier {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('users-saved-item');
  Future<void> addToSaved({
    required String itemImage,
    required String title,
    required String price,
    required String location,
  }) async {
    SavedModel savedModel = SavedModel(
      itemImage: itemImage,
      title: title,
      price: price,
      location: location,
    );

    collectionRef
        .doc(currentUser!.email)
        .collection('items')
        .doc()
        .set(savedModel.toMap())
        .then((value) {
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> deleteFromSaved({
    required String docx,
  }) async {
    collectionRef
        .doc(currentUser!.email)
        .collection('items')
        .doc(docx)
        .delete()
        .then((value) {
    }).catchError((error) {
      print(error.toString());
    });
  }
}
