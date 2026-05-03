import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/storage_service.dart';

class ProfileProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> updateProfile({
    required User user,
    String? displayName,
    String? photoUrl,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }
      if (photoUrl != null) {
        await user.updatePhotoURL(photoUrl);
      }
      await user.reload();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> uploadProfileImage(User user, File file) async {
    try {
      final path = 'users/${user.uid}/profile_image.jpg';
      return await _storageService.uploadFile(path: path, file: file);
    } catch (e) {
      rethrow;
    }
  }
}
