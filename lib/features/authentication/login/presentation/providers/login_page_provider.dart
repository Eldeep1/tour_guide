

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/auth_service.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/authentication/login/data/models/login_request.dart';
import 'package:tour_guide/features/authentication/login/data/models/login_response.dart';
import 'package:tour_guide/features/authentication/login/data/repos/login_repo.dart';
import 'package:tour_guide/features/authentication/login/presentation/providers/login_repo_provider.dart';

final loginPageProvider= AsyncNotifierProvider<LoginPageNotifier,LoginResponse>(LoginPageNotifier.new);
class LoginPageNotifier extends AsyncNotifier<LoginResponse>{

   LoginRepo? loginRepo;
  @override
  FutureOr<LoginResponse> build() {
    loginRepo=ref.watch(loginRepoProvider);
    return ref.watch(loginResponseProvider);
  }
  Future<void> login({
    required LoginRequest loginRequest,
  }) async {
    state = const AsyncValue.loading();

    // 🛑 cache the providers before the await
    final loginResponseNotifier = ref.read(loginResponseProvider.notifier);
    final authStatusNotifier = ref.read(authServiceProvider.notifier);

    final result = await loginRepo!.login(loginRequest: loginRequest);

    result.fold(
          (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
          (loginResponse) {
        loginResponseNotifier.state = loginResponse;
        authStatusNotifier.state = const AsyncValue.data(AuthStatus.authenticated);
        state = AsyncValue.data(loginResponse);
      },
    );
  }

}