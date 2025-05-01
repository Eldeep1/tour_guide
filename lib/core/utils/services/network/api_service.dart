import 'package:dio/dio.dart';
import 'package:tour_guide/core/utils/api_end_points.dart';

class ApiService {
  final Dio _dio;
  final Map<String, dynamic> requestHeaders = {
    "Content-Type": "application/json",
  };
  final _baseUrl = ApiEndpoints.baseUrl;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? parameters,
    String? bearerToken,
    Map<String, dynamic>? headers,
  }) async {
     Map<String,dynamic> tmpRequestHeaders={};
    if (bearerToken != null) {
      
      tmpRequestHeaders["Authorization"] = "Bearer $bearerToken";
    }
    if (headers != null) {
      tmpRequestHeaders.addAll(headers);
    }
    tmpRequestHeaders.addAll(requestHeaders);
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      queryParameters: parameters,
      options: Options(headers: tmpRequestHeaders),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    String? bearerToken,
  }) async {
    Map<String,dynamic> tmpRequestHeaders={};

    if (bearerToken != null) {
      tmpRequestHeaders["Authorization"] = "Bearer $bearerToken";
    }
    if (headers != null) {
      tmpRequestHeaders.addAll(headers);
    }

    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: parameters,
      options: Options(headers: tmpRequestHeaders),
      // cancelToken: _cancelToken, // <-- and here
    );

    return response.data;
  }


}
