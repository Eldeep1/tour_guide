import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/network/api_service.dart';
import 'package:tour_guide/core/utils/services/storage/secure_storage.dart';
import 'package:tour_guide/core/utils/services/token_operations/token_operation_repo.dart';
import 'package:tour_guide/core/utils/services/token_operations/token_operations_imp.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_response.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/model/chat_headers_model.dart';

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

final isLoggingOutProvider = StateProvider<bool>((ref) => false);

final chatHeadersProvider = StateProvider<ChatHeaders>((ref) {
  return ChatHeaders();
});


