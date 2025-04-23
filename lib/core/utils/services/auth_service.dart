// 1- check if the token is stored locally,
//  if yes store them on tokensProvider,
//  if no set isLoggedProvider to false and end
// 2- check if the stored tokens valid from the server side or not,
//  if valid, set the isLoggedProvider to true

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ehgezly/core/errors/failure.dart';
import 'package:ehgezly/core/utils/services/providers/providers.dart';
import 'package:ehgezly/core/utils/services/token_operations/token_operation_repo.dart';
import 'package:ehgezly/features/Authentication/login/data/models/login_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus {
  authenticated,
  notAuthenticated,
  networkError,
  storageError,
}
final authServiceProvider = AsyncNotifierProvider<AuthServiceNotifier, AuthStatus>(
  AuthServiceNotifier.new,
);


class AuthServiceNotifier extends AsyncNotifier<AuthStatus>{
  late TokenOperation tokenOperation;

  @override
  Future<AuthStatus> build() async {
    tokenOperation = ref.watch(tokenOperationsProvider); // ✅ inject here

    state = AsyncValue.loading();

    final tokenExist = await isTokensStored();
    if (tokenExist.isLeft()) {
      return AuthStatus.storageError;
    }

    final exists = tokenExist.getOrElse(() => false);
    print(exists);

    if (!exists) {
      return AuthStatus.notAuthenticated;
    }
    final tokenVerified = await verifyTheToken();
    if (tokenVerified.isRight()) {
      return AuthStatus.authenticated;
    }

    final failure = tokenVerified.swap().getOrElse(() => NewFailure("unknown"));
    if (failure is ServerFailure && failure.type == ServerErrorType.network) {
      return AuthStatus.networkError;
    }

    final tokenRefreshed = await refreshTheToken();
    if (tokenRefreshed.isRight()) {
      return AuthStatus.authenticated;
    }

    final refreshFailure = tokenRefreshed.swap().getOrElse(() => NewFailure("unknown"));
    if (refreshFailure is ServerFailure && refreshFailure.type == ServerErrorType.network) {
      return AuthStatus.networkError;
    }

    print("did we really hit it!");
    return AuthStatus.notAuthenticated;
  }


  Future<Either<Failure,bool>> isTokensStored()async{
    print("we caught it 1");

    //should save the retrieved tokens.
    final Either<Failure,LoginResponse>tokens =await tokenOperation.retrieveTokens();
    return tokens.fold(
      (failure) =>left(failure),
        (loginResponse){
        ref.read(loginResponseProvider.notifier).state=loginResponse;

        if(loginResponse.accessToken.isEmpty){
          print("we caught it2");

          return right(false);
        }
        return right(true);
      }
    );
}

  Future<Either<Failure,bool>> verifyTheToken()async{
    final Either<Failure,void>tokens =await tokenOperation.verifyToken(loginResponse: ref.read(loginResponseProvider));
    return tokens.fold(
            (failure) {
              print("verification errrror");
              print(failure.message);
              return left(failure);
            },
            (loginResponse){
              print("token verified yaaay");
              return right(true);
        }
    );
  }

  Future<Either<Failure,bool>> refreshTheToken()async{
    final Either<Failure,String>tokens =await tokenOperation.refreshTheToken(refreshToken: ref.read(loginResponseProvider).refreshToken);
    return tokens.fold(
            (failure) =>left(failure),
            (newToken){
              ref.read(loginResponseProvider.notifier).state.accessToken=newToken;
          return right(true);
        }
    );
  }
}
