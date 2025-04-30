
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_response.dart';
import 'package:tour_guide/features/Chat/chat_headers/presentation/providers/side_bar_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_repo_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';

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
    ref.onDispose(() {
      print("the most important one disposed!");
    },);
    tokenOperation = ref.watch(tokenOperationsProvider); 

    state = AsyncValue.loading();

    final tokenExist = await isTokensStored();
    if (tokenExist.isLeft()) {
      return AuthStatus.storageError;
    }

    final exists = tokenExist.getOrElse(() => false);
    print("from auth service, the token exists");

    if (!exists) {
      print("from auth service, the token not exists");

      return AuthStatus.notAuthenticated;
    }
    final tokenVerified = await verifyTheToken();
    if (tokenVerified.isRight()) {
      print("from auth service, the token verified");
      return AuthStatus.authenticated;
    }
    print("from auth service, the token is not verified");

    final failure = tokenVerified.swap().getOrElse(() => NewFailure("unknown"));
    if (failure is ServerFailure &&( failure.type != ServerErrorType.authentication || failure.type !=ServerErrorType.client )) {

      print("from auth service, the token is not verified due to network errors");
      return AuthStatus.networkError;
    }

    final tokenRefreshed = await refreshTheToken();
    if (tokenRefreshed.isRight()) {
      print("from auth service, the token is refreshed");

      return AuthStatus.authenticated;
    }
    print("from auth service, the token is not refreshed");

    final refreshFailure = tokenRefreshed.swap().getOrElse(() => NewFailure("unknown"));
    if (refreshFailure is ServerFailure &&( refreshFailure.type != ServerErrorType.authentication || refreshFailure.type !=ServerErrorType.client )) {
      print("from auth service, the token is not due to network error");
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

  Future<void> clearTheTokens()async{
    await tokenOperation.deleteTokens();
  }
  Future<void> logOut()async{
    print("we are on the logut");

    // state = AsyncData(AuthStatus.notAuthenticated);
    state = AsyncData(AuthStatus.notAuthenticated);
    try{
      await tokenOperation.logout(refreshToken: ref.read(loginResponseProvider).refreshToken);
      print("but the login response tokens are: ");
      print("refresh : ${ref.watch(loginResponseProvider).refreshToken}");
      print("access : ${ref.watch(loginResponseProvider).accessToken}");
       ref.read(apiServiceProvider).cancelAllRequests();

       ref.invalidate(loginResponseProvider);
       ref.invalidate(chatHeadersProvider);
       ref.invalidate(sideBarProvider);
       ref.invalidate(sideBarProvider);
       ref.invalidate(chatDataProvider);
       ref.invalidate(chatRepoProvider);
       ref.invalidate(appBarHeaderProvider);

      state = AsyncData(AuthStatus.notAuthenticated);


    }
    catch(e){
      state = AsyncData(AuthStatus.notAuthenticated);

      print(e);
    print("we are having an error");
    }
  }
}
