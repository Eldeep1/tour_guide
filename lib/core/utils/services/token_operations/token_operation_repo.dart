import 'package:dartz/dartz.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_response.dart';


abstract class TokenOperation{
  //1- save token to device
  //2- update the token
  //3- verify the token integrity?

  Future<Either<Failure,void>> saveTokens({
    required LoginResponse loginResponse,
});
  Future<Either<Failure,LoginResponse>> retrieveTokens();

  Future<Either<Failure,void>> updateToken({
    required LoginResponse loginResponse,
  });

  //is that even useful?
  Future<Either<Failure,void>> verifyToken({
    required LoginResponse loginResponse,
  });

  Either<Failure,Map<String, dynamic>> decodeToken({
    required LoginResponse loginResponse,
  });

  Future<Either<Failure,void>> deleteTokens();

  Future<Either<Failure, String>> refreshTheToken({
    required String refreshToken,
  });
  Future<void> logout({required String refreshToken});
}