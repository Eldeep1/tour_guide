import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  // change it with your api url, when getting it
  final baseUrl = "";

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String,dynamic>? parameters,
    Map<String,dynamic>? headers
  }) async {
    var response = await _dio.get(
        '$baseUrl$endPoint',
        queryParameters: parameters,
        options: Options(headers: headers,),
    );
    return response.data;
  }
}
