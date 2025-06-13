
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/authentication/login/data/models/login_response.dart';
import 'package:tour_guide/features/chat/chat_headers/presentation/providers/side_bar_provider.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/chat_repo_provider.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/page_variables_provider.dart';

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

    if (!exists) {

      return AuthStatus.notAuthenticated;
    }
    final tokenVerified = await verifyTheToken();
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
    return AuthStatus.notAuthenticated;
  }


  Future<Either<Failure,bool>> isTokensStored()async{

    //should save the retrieved tokens.
    final Either<Failure,LoginResponse>tokens =await tokenOperation.retrieveTokens();
    return tokens.fold(
      (failure) =>left(failure),
        (loginResponse){
        ref.read(loginResponseProvider.notifier).state=loginResponse;

        if(loginResponse.accessToken.isEmpty){

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
              return left(failure);
            },
            (loginResponse){
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

  Future<void> clearTheTokens()async{
    await tokenOperation.deleteTokens();
  }
  Future<void> logOut()async{
    state = AsyncData(AuthStatus.notAuthenticated);
    // state = AsyncData(AuthStatus.notAuthenticated);
    state = AsyncData(AuthStatus.notAuthenticated);
    try{
      await tokenOperation.logout(refreshToken: ref.read(loginResponseProvider).refreshToken);

      ref.invalidate(loginResponseProvider);
      ref.invalidate(sideBarProvider);
       ref.invalidate(chatDataProvider);
       ref.invalidate(chatRepoProvider);
       ref.invalidate(appBarHeaderProvider);
       ref.invalidate(isLoggingOutProvider);



    }
    catch(e){
      state = AsyncData(AuthStatus.notAuthenticated);
    }
  }
}
