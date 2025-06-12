
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/repo/chat_headers_repo.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/repo/chat_headers_repo_imp.dart';

final chatHeadersRepoProvider=StateProvider<ChatHeadersRepo>((ref){
  final apiService=ref.watch(apiServiceProvider);
  final accessToken=ref.watch(loginResponseProvider);
  return ChatHeadersRepoImp(apiService,accessToken.accessToken);
});