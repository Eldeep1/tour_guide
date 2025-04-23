import 'package:dio/dio.dart';
import 'package:ehgezly/core/utils/services/api_service.dart';
import 'package:ehgezly/core/utils/services/storage/secure_storage.dart';
import 'package:ehgezly/core/utils/services/token_operations/token_operation_repo.dart';
import 'package:ehgezly/core/utils/services/token_operations/token_operations_imp.dart';
import 'package:ehgezly/features/Authentication/login/data/models/login_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(Dio());
});

// Provides a global instance of SecureStorage
final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});

final tokenOperationsProvider=Provider<TokenOperation>((ref){
  return TokenOperationsImp();
});

final loginResponseProvider = StateProvider<LoginResponse>((ref) => LoginResponse(accessToken: "", refreshToken: ""));
