

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Authentication/register/data/models/register_request.dart';
import 'package:tour_guide/features/Authentication/register/data/models/register_response.dart';
import 'package:tour_guide/features/Authentication/register/data/repos/register_repo.dart';
import 'package:tour_guide/features/Authentication/register/presentation/providers/register_repo_provider.dart';

final registerPageProvider = AsyncNotifierProvider<RegisterPageNotifier,RegisterResponse>(() => RegisterPageNotifier(),);

class RegisterPageNotifier extends AsyncNotifier<RegisterResponse>{

  late RegisterRepo registerRepo;
  @override
  FutureOr<RegisterResponse> build() async{
    registerRepo=ref.watch(registerRepoProvider);
    return RegisterResponse();
  }

  Future<void> register({
    required RegisterRequest registerRequest
}) async {
    state=AsyncValue.loading();
  final response= await registerRepo.register(registerRequest: registerRequest);
  return response.fold((failure){
    state = AsyncError(failure.message, StackTrace.current);
  }, (response){
    print(response.data!.name);
    state= AsyncData(response);
  });
}

}