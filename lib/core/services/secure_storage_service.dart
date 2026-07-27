import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/storage_keys.dart';

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

class SecureStorageService {
  SecureStorageService({
    FlutterSecureStorage? storage,
  }) : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await write(StorageKeys.accessToken, accessToken);
    await write(StorageKeys.refreshToken, refreshToken);
    await write(StorageKeys.isLoggedIn, 'true');
  }

  Future<String?> getAccessToken() => read(StorageKeys.accessToken);

  Future<String?> getRefreshToken() => read(StorageKeys.refreshToken);

  Future<bool> isLoggedIn() async {
    final value = await read(StorageKeys.isLoggedIn);
    return value == 'true';
  }

  Future<void> clearSession() async {
    await delete(StorageKeys.accessToken);
    await delete(StorageKeys.refreshToken);
    await delete(StorageKeys.userId);
    await delete(StorageKeys.userName);
    await delete(StorageKeys.isLoggedIn);
  }
}
