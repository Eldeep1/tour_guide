import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/core/utils/api_end_points.dart';
import 'package:tour_guide/core/utils/services/network/api_service.dart';
import 'package:tour_guide/core/utils/services/storage/secure_storage.dart';
import 'package:tour_guide/core/utils/services/token_operations/token_operation_repo.dart';
import 'package:tour_guide/features/authentication/login/data/models/login_response.dart';

class TokenOperationsImp extends TokenOperation {
  final secureStorage = SecureStorage();
  ApiService apiService = ApiService(Dio());

  @override
  Future<Either<Failure, void>> deleteTokens() async {
    try {
      await secureStorage.deleteAll();
      return right(null);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Map<String, dynamic>> decodeToken(
      {required LoginResponse loginResponse}) {
    try {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(loginResponse.accessToken);
      return right(decodedToken);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> retrieveTokens() async {
    try {
      String? accessToken = await secureStorage.readValue("access_token") ?? "";
      String? refreshToken =
          await secureStorage.readValue("refresh_token") ?? "";
      final loginResponse =
          LoginResponse(accessToken: accessToken, refreshToken: refreshToken);
      return right(loginResponse);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTokens(
      {required LoginResponse loginResponse}) async {
    try {
      await secureStorage.writeValue("access_token", loginResponse.accessToken);
      await secureStorage.writeValue(
          "refresh_token", loginResponse.refreshToken);
      return right(null);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateToken(
      {required LoginResponse loginResponse}) async {
    try {
      await secureStorage.writeValue("access_token", loginResponse.accessToken);
      return right(null);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyToken(
      {required LoginResponse loginResponse}) async {
    try {

      Map<String,dynamic> parameters={"token":loginResponse.accessToken};

    await apiService.post(
        endPoint: ApiEndpoints.verify,
        parameters: parameters,
      );

    return right(null);

    } catch (e) {

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> refreshTheToken({
    required String refreshToken,
  }) async {
    Map<String, String> requestParameter = {"refresh": refreshToken};
    try {
      Map<String, dynamic> response = await apiService.post(
        endPoint: ApiEndpoints.refreshAccess,
        parameters: requestParameter,
      );
      final newToken = response['data']["access"];
      if (newToken != null) {
        return right(newToken);
      } else {
        return left(ServerFailure("unexpected error!!!"));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(NewFailure(e.toString()));
    }
  }
  @override
  Future<void> logout({
    required String refreshToken,
})async {
    Map<String, dynamic> parameters={"refresh":refreshToken};

    await deleteTokens();
    await apiService.post(endPoint: ApiEndpoints.logOut,parameters: parameters);
  }
}
