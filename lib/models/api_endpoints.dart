//import 'package:dio/dio.dart';

class ApiEndpoints {
  //Dio configration
  static const String baseUrl = 'https://groove-street.up.railway.app';
  static const int receiveTimeout = 15;
  static const int connectTimeout = 15;
  

  //Endpoints
  static const String todos = '/todos';
  static const String login = '/auth/login';
  static const String signup = '/auth/register';
}