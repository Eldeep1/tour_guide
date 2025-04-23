import 'package:dartz/dartz.dart';
import 'package:ehgezly/core/errors/failure.dart';
import 'package:ehgezly/features/Authentication/login/data/models/login_request.dart';
import 'package:ehgezly/features/Authentication/login/data/models/login_response.dart';

abstract class LoginRepo {
  Future<Either<Failure,LoginResponse>> login({
    required LoginRequest loginRequest,
  });
}
