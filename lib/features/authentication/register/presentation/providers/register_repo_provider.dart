import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/authentication/register/data/repos/register_repo.dart';
import 'package:tour_guide/features/authentication/register/data/repos/register_repo_imp.dart';

final registerRepoProvider=Provider<RegisterRepo>(
  (ref) {
    final apiService=ref.read(apiServiceProvider);
    return RegisterRepoImp(apiService);
  },
);