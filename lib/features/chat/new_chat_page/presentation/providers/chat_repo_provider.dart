
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/network/api_service.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/authentication/login/data/models/login_response.dart';
import 'package:tour_guide/features/chat/new_chat_page/data/repo/chat_repo.dart';
import 'package:tour_guide/features/chat/new_chat_page/data/repo/chat_repo_imp.dart';

final chatRepoProvider=Provider<ChatRepo>((ref) {
  final ApiService apiService=ref.watch(apiServiceProvider);
  final LoginResponse loginResponse=ref.watch(loginResponseProvider);
  return ChatRepoImp(apiService, loginResponse.accessToken);
},);