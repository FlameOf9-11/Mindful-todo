import 'package:flutter/cupertino.dart';

import 'api_client.dart';
import 'api_endpoints.dart';
import '../models/token_storage.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<void> login({required String email, required String password}) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );

    final token = response.data['token'] as String;
    await TokenStorage.saveToken(token);

    
  }
  Future<void> signup({
      required String name,
      required String email,
      required String password,
    }) async {
      final response = await _apiClient.post(
        ApiEndpoints.signup,
        data: {'name': name, 'email': email, 'password': password},
      );

      await login(email: email,password: password);
    }

    Future<void> logout() async{
      await TokenStorage.deleteToken();
    }
}
