import 'package:dartz/dartz.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/features/Authentication/register/data/models/register_request.dart';
import 'package:tour_guide/features/Authentication/register/data/models/register_response.dart';

abstract class RegisterRepo{
  Future<Either<Failure,RegisterResponse>> register({
    required RegisterRequest registerRequest,
});
}