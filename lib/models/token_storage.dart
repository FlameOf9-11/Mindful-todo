import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  //token
  static const String _tokenKey = 'auth_token';
  //keys
  static const String _rememberMeKey = 'rememeber_me';
  static const String _savedEmailKey = 'saved_email';
  static Future<void> saveRememberMe({
    required bool remember,
    required String email,
  }) async {
    if (remember) {
      await _storage.write(key: _rememberMeKey, value: 'true');
      await _storage.write(key: _savedEmailKey, value: email);
    } else {
      await _storage.delete(key: _rememberMeKey);
      await _storage.delete(key: _savedEmailKey);
    }
  }

  static Future<Map<String, dynamic>> getSavedCredentials() async {
    final remember = await _storage.read(key: _rememberMeKey);
    final email = await _storage.read(key: _savedEmailKey);
    return {'remember': remember == 'true', 'email': email ?? ''};
  }

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  //save token *_*
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  //Get token &_&
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  //Delete Token 5-5

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  //check if the user has an active session

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
