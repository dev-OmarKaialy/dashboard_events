import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoriesData {
  final db = FirebaseFirestore.instance;
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getProducts(
      String catId) async {
    final result = (await db
            .collection('packages')
            .where('category',
                isEqualTo: (await db.collection('categories').doc(catId).get())
                    .reference)
            .get())
        .docs;
    return result;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getCategories() async {
    final result = (await db.collection('categories').get()).docs;
    print(result.length);
    return result;
  }

  Future<void> addCategory(name, des, File image) async {
    final r = await FirebaseStorage.instance
        .ref()
        .child(
            'images/${Random(DateTime.now().millisecondsSinceEpoch ~/ 100000).nextInt(100000000)}.png')
        .putData(image.readAsBytesSync());
    final t = await db.collection('categories').add({
      'name': name,
      'descrption': des,
      'image': await r.ref.getDownloadURL()
    });
    return;
  }

  Future<void> addProduct(
      {required String name,
      required double price,
      required String category,
      required int capacity,
      required File image}) async {
    final r = await FirebaseStorage.instance
        .ref()
        .child(
            'images/${Random(DateTime.now().millisecondsSinceEpoch ~/ 100000).nextInt(100000000)}.png')
        .putData(image.readAsBytesSync());
    await db.collection('packages').add({
      'name': name,
      'category':
          (await db.collection('categories').doc(category).get()).reference,
      'image': await r.ref.getDownloadURL(),
      'capacity': capacity,
      'rate': 0,
      'price': price,
    });
    return;
  }
}
