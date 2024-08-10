import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackData {
  final db = FirebaseFirestore.instance;
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getFeedBacks() async {
    final result = await db.collection('feedback').get();
    return result.docs;
  }
}
