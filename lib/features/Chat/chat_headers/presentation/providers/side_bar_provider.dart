import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/model/chat_headers_model.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/repo/chat_headers_repo.dart';
import 'package:tour_guide/features/Chat/chat_headers/presentation/providers/chat_headers_repo_provider.dart';

final sideBarProvider = AsyncNotifierProvider<SideBarNotifier,ChatHeaders>(() {
  return SideBarNotifier();
},);
ChatHeaders? _cachedChatHeaders;

class SideBarNotifier extends AsyncNotifier<ChatHeaders> {
  late final ChatHeadersRepo chatHeadersRepo;

  @override
  FutureOr<ChatHeaders> build() async {
    chatHeadersRepo = ref.watch(chatHeadersRepoProvider);

    if (_cachedChatHeaders != null) {
      return _cachedChatHeaders!;
    }

    final result = await chatHeadersRepo.getChatHeaders();
    return result.fold((failure) {
      throw Exception(failure.message);
    }, (chatHeaders) {
      _cachedChatHeaders = chatHeaders;
      return chatHeaders;
    });
  }

  Future<void> refreshHeaders() async {
    state = const AsyncLoading();
    final result = await chatHeadersRepo.getChatHeaders();
    result.fold(
          (failure) {
        state = AsyncError(failure.message, StackTrace.current);
      },
          (chatHeaders) {
        _cachedChatHeaders = chatHeaders;
        state = AsyncData(chatHeaders);
      },
    );
  }
}