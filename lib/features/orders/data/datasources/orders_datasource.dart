import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersData {
  final db = FirebaseFirestore.instance;
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getOrders() async {
    final result = (await db.collection('orders').orderBy('status').get()).docs;
    print(result.length);
    return result;
  }

  Future<void> toggleOrder(String id, bool accepted) async {
    final result = await db
        .collection('orders')
        .doc(id)
        .update({'status': accepted ? 2 : 0});

    return;
  }
}
