import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Generic method to get a stream of data from a collection
  Stream<List<T>> streamCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String id) builder,
    Query Function(Query query)? queryBuilder,
  }) {
    Query query = _db.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => builder(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  // Generic method to add data
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _db.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  // Generic method to delete data
  Future<void> deleteData({required String path}) async {
    final reference = _db.doc(path);
    await reference.delete();
  }

  // Generic method to add a document and get its ID
  Future<DocumentReference> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    return await _db.collection(path).add(data);
  }

  // Get a single document
  Future<T?> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String id) builder,
  }) async {
    final doc = await _db.doc(path).get();
    if (doc.exists) {
      return builder(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }
}
