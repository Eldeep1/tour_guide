import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/Authentication/login/data/repos/login_repo.dart';
import 'package:tour_guide/features/Authentication/login/data/repos/login_repo_impl.dart';

final loginRepoProvider=StateProvider<LoginRepo>((ref){
  final apiService=ref.watch(apiServiceProvider);
  final tokenOperation=ref.watch(tokenOperationsProvider);
  return LoginRepoImpl(apiService, tokenOperation);
});