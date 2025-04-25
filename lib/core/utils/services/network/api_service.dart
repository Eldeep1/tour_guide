import 'package:dio/dio.dart';
import 'package:tour_guide/core/utils/api_end_points.dart';

class ApiService {
  final Dio _dio;
  final Map<String,dynamic> requestHeaders={
    "Content-Type": "application/json",
  };
  final _baseUrl = ApiEndpoints.baseUrl;

  ApiService(this._dio);


  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String,dynamic>? parameters,
    String? bearerToken,
    Map<String,dynamic>? headers}) async {
    if (bearerToken != null) {
      requestHeaders["Authorization"] = "Bearer $bearerToken";
    }
    if(headers!=null) {
      requestHeaders.addAll(headers);
    }
    var response = await _dio.get('$_baseUrl$endPoint',queryParameters: parameters,options: Options(headers: requestHeaders));
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String,dynamic>? parameters,
    Map<String,dynamic>? headers,
    String? bearerToken,
  }) async {
    if (bearerToken != null) {
      requestHeaders["Authorization"] = "Bearer $bearerToken";
    }
    if(headers!=null) {
      requestHeaders.addAll(headers);
    }
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: parameters,
      options: Options(headers: requestHeaders,),
    );

    return response.data;
  }

}
