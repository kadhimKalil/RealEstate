import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item_model.dart';

class ItemProvider with ChangeNotifier {
  List<ItemModel> item = [];

  

  Future<void> fetchItems() async {
    await FirebaseFirestore.instance
        .collection('items')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((decument) {
        item.add(ItemModel.fromJson(json: decument.data()));
      });

      notifyListeners();
    }).catchError((error) {
      print('ree' + error.toString());
    });
  }
}
