import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'api_endpoints.dart';
import '../models/token_storage.dart';
import '../main.dart';
import 'package:Mindful/routes/app_routes.dart';

class ApiClient {
  late final Dio _dio;

  // Singleton pattern: ensures all services share the exact same client
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveTimeout: const Duration(seconds: ApiEndpoints.receiveTimeout),
        connectTimeout: const Duration(seconds: ApiEndpoints.connectTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 1. Authorization Interceptor (Step 4)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // If token expired or is invalid (401), clear the token
          if (e.response?.statusCode == 401) {
            await TokenStorage.deleteToken();

            scaffoldMessengerKey.currentState?.showSnackBar(
              const SnackBar(
                content: Text('Session expired. Please log in again'),
                backgroundColor: Colors.redAccent,
                duration: Duration(seconds: 4),
              ),
            );
            //kick the user to login screen :)
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.loginRoute,
              (route) => false,
            );
          }
          return handler.next(e);
        },
      ),
    );

    // 2. Logging Interceptor
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  // GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _errorHandler(e);
    }
  }

  // POST
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _errorHandler(e);
    }
  }

  // PATCH
  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await _dio.patch(path, data: data);
    } on DioException catch (e) {
      throw _errorHandler(e);
    }
  }

  // DELETE
  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } on DioException catch (e) {
      throw _errorHandler(e);
    }
  }

  Exception _errorHandler(DioException e) {
    if (e.response != null) {
      final serverMessage =
          e.response?.data is Map && e.response?.data['message'] != null
          ? e.response?.data['message']
          : '${e.response?.statusCode} - ${e.response?.statusMessage}';
      return Exception(serverMessage);
    } else {
      return Exception('Client Error: Please check your connection.');
    }
  }
}
