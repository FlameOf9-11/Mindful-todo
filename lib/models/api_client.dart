import 'package:dio/dio.dart';
import 'api_endpoints.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient(){
    _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveTimeout: const Duration(seconds: ApiEndpoints.receiveTimeout),
      connectTimeout: Duration(seconds: ApiEndpoints.connectTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    ),
  );
  
  //shows the recived and sent data in the terminal
  _dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
  }
  //get Method
  Future<Response> get(String path,{Map<String,dynamic>? queryParameters})async{

    try{
      return await _dio.get(path,queryParameters: queryParameters);
    }on DioException catch(e){
      throw _errorHandler(e);
    }
  }
  //post Method
  Future<Response> post(String path,{dynamic data})async{
    try{
      return await _dio.post(path,data: data);

    }on DioException catch(e){
      throw _errorHandler(e);
    }
  }
  //put Method
  Future<Response> patch(String path,{dynamic data}) async{
    try{
      return _dio.patch(path,data: data);
    }on DioException catch(e){
      throw _errorHandler(e);
    }
  }

  Future<Response> delete(String path,{dynamic data}) async{
    try{
      return await _dio.delete(path,data: data);
    }on DioException catch(e){
      throw _errorHandler(e);
    }
  }
  Exception _errorHandler(DioException e){
    if(e.response !=null){
      return Exception('Server Error: ${e.response?.statusCode} - ${e.response?.statusMessage}' );
    }
    else{
      return Exception('Client Error: Please check your connection.');
    }
  }

  
}
