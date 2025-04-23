// 1- check if the token is stored locally,
//  if yes store them on tokensProvider,
//  if no set isLoggedProvider to false and end
// 2- check if the stored tokens valid from the server side or not,
//  if valid, set the isLoggedProvider to true

import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_response.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/chat_headers_model.dart';

import 'token_operations/token_operation_repo.dart';

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
    tokenOperation = ref.watch(tokenOperationsProvider); 

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
    final tokenVerified = await getChatHeaders();
    if (tokenVerified.isRight()) {
      return AuthStatus.authenticated;
    }

    final failure = tokenVerified.swap().getOrElse(() => NewFailure("unknown"));
    if (failure is ServerFailure &&( failure.type != ServerErrorType.authentication || failure.type !=ServerErrorType.client )) {
      return AuthStatus.networkError;
    }

    final tokenRefreshed = await refreshTheToken();
    if (tokenRefreshed.isRight()) {
      return AuthStatus.authenticated;
    }

    final refreshFailure = tokenRefreshed.swap().getOrElse(() => NewFailure("unknown"));
    if (refreshFailure is ServerFailure &&( refreshFailure.type != ServerErrorType.authentication || refreshFailure.type !=ServerErrorType.client )) {
      return AuthStatus.networkError;
    }
    // clear the tokens if it exists and expired
    clearTheTokens();
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

  Future<Either<Failure,bool>> getChatHeaders() async {
    final Either<Failure, ChatHeaders> chatHeaders= await tokenOperation.verifyToken(loginResponse: ref.read(loginResponseProvider));
    return chatHeaders.fold(
            (failure) {
          print("verification errrror");
          print(failure.message);
          return left(failure);
        },
            (chatHeaders){
              ref.read(chatHeadersProvider.notifier).state=chatHeaders;
          print("token verified yaaay");
          return right(true);
        }
    );
  }
  Future<void> clearTheTokens()async{
    await tokenOperation.deleteTokens();
  }
}
