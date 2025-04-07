import 'package:dio/dio.dart';
import 'package:tour_guide/constants.dart';

class ApiService {
  final Dio _dio=Dio();

  // change it with your api url, when getting it
  final baseUrl = apiLink;

  // ApiService(this._dio);

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

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String,dynamic>? parameters,
    Map<String,dynamic>? headers
  }) async {
    Map<String,dynamic> requestHeaders={
      "Content-Type": "application/json",
    };
    if(headers!=null) {
      requestHeaders.addAll(headers);
    }
    var response = await _dio.post(
      '$baseUrl$endPoint',
      data: parameters,
      options: Options(headers: requestHeaders,),
    );
    return response.data;
  }


}
