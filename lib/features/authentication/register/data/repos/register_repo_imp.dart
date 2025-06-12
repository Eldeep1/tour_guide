import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/core/utils/api_end_points.dart';
import 'package:tour_guide/core/utils/services/network/api_service.dart';
import 'package:tour_guide/features/authentication/register/data/models/register_request.dart';
import 'package:tour_guide/features/authentication/register/data/models/register_response.dart';
import 'package:tour_guide/features/authentication/register/data/repos/register_repo.dart';

class RegisterRepoImp extends RegisterRepo {
  final ApiService apiService;
  RegisterRepoImp(this.apiService);

  @override
  Future<Either<Failure, RegisterResponse>> register({
    required RegisterRequest registerRequest
}) async {
    try {
      final response = await apiService.post(
        endPoint: ApiEndpoints.register,
        parameters: registerRequest.toJson(),
      );
      return right(RegisterResponse.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(NewFailure(e.toString())); // Handle unexpected errors
    }
  }
}
