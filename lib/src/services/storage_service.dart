import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload file to Firebase Storage
  Future<String> uploadFile({
    required String path,
    required File file,
  }) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  // Delete file from Firebase Storage
  Future<void> deleteFile({required String path}) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.delete();
    } catch (e) {
      rethrow;
    }
  }
}
