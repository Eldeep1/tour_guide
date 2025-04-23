import 'package:dartz/dartz.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_request.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_response.dart';


abstract class LoginRepo {
  Future<Either<Failure,LoginResponse>> login({
    required LoginRequest loginRequest,
  });
}
