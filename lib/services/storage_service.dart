import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  final _storage = Hive.box("storage");

  Future<String?> get getToken async => await _storage.get("token");

  Future storeUserToken({
    required String token,
  }) async {
    await _storage.put("token", token);
  }

  Future deleteUserCredentials() async {
    try {
      await _storage.delete('token');
      await _storage.clear();
    } catch (e) {
      debugPrint("Error clearing user data: $e");
    }
  }
}
