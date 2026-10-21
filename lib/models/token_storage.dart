import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const String _tokenKey = 'auth_token';
  static const String _savedAccountsKey = 'saved_accounts'; // Single key for the list

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // Save or update an account in the list
  static Future<void> saveRememberMe({
    required bool remember,
    required String email,
    required String password,
  }) async {
    // Get existing accounts
    final String? accountsJson = await _storage.read(key: _savedAccountsKey);
    List<dynamic> accounts = accountsJson != null ? jsonDecode(accountsJson) : [];

    // Remove the account if it already exists in the list to avoid duplicates
    accounts.removeWhere((acc) => acc['email'] == email);

    if (remember) {
      // Add the new/updated account
      accounts.add({'email': email, 'password': password});
    }

    // Save the updated list back to storage
    await _storage.write(key: _savedAccountsKey, value: jsonEncode(accounts));
  }

  // Retrieve all saved accounts
  static Future<List<Map<String, dynamic>>> getSavedAccounts() async {
    final String? accountsJson = await _storage.read(key: _savedAccountsKey);
    if (accountsJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(accountsJson);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // Token methods remain unchanged...
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}