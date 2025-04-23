import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ehgezly/core/errors/failure.dart';
import 'package:ehgezly/core/utils/services/api_service.dart';
import 'package:ehgezly/core/utils/services/token_operations/token_operation_repo.dart';
import 'package:ehgezly/features/Authentication/login/data/models/login_request.dart';
import 'package:ehgezly/features/Authentication/login/data/models/login_response.dart';
import 'package:ehgezly/features/Authentication/login/data/repos/login_repo.dart';

class LoginRepoImpl extends LoginRepo{
  ApiService apiService;
  TokenOperation tokenOperation;
  // TECHNICAL DEPT
  // should replace the secure storage with a storage interface
  LoginRepoImpl(this.apiService,this.tokenOperation);
  @override
  Future<Either<Failure, LoginResponse>> login({required LoginRequest loginRequest}) async {
    try {
      print(loginRequest.toJson());

      // 1. Send request to backend
      final response = await apiService.post(
        endPoint: "auth/token/",
        parameters: loginRequest.toJson(),
      );
      // 2. Convert response to LoginResponse
      LoginResponse loginResponse = LoginResponse.fromJson(response);

      // 3. Store tokens securely
      final Either<Failure, void> result =   await tokenOperation.saveTokens(loginResponse: loginResponse);

      //4.
      return result.fold(
      (failure) => left(failure),
      (r) => right(loginResponse),);

    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(NewFailure(e.toString())); // Handle unexpected errors
    }
  }
}