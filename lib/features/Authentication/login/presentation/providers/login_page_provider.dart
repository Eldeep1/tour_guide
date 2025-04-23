

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/auth_service.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_request.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_response.dart';
import 'package:tour_guide/features/Authentication/login/data/repos/login_repo.dart';
import 'package:tour_guide/features/Authentication/login/presentation/providers/login_repo_provider.dart';

final loginPageProvider= AsyncNotifierProvider<LoginPageNotifier,LoginResponse>(LoginPageNotifier.new);
class LoginPageNotifier extends AsyncNotifier<LoginResponse>{

  late LoginRepo loginRepo;
  @override
  FutureOr<LoginResponse> build() {
    loginRepo=ref.watch(loginRepoProvider);
    return ref.watch(loginResponseProvider);
  }
  Future<void>login({
    required LoginRequest loginRequest,
}) async {
    state = AsyncValue.loading();
    final result =await loginRepo.login(loginRequest: loginRequest);

    result.fold(
        (failure){
         state= AsyncError(failure.message, StackTrace.current);
        }, (loginResponse){
          ref.read(loginResponseProvider.notifier).state=loginResponse;
          ref.read(authServiceProvider.notifier).state=AsyncValue.data(AuthStatus.authenticated);
          state= AsyncData(loginResponse);
    });
  }
}