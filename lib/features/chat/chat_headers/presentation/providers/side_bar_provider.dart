import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/chat/chat_headers/data/model/chat_headers_model.dart';
import 'package:tour_guide/features/chat/chat_headers/data/repo/chat_headers_repo.dart';
import 'package:tour_guide/features/chat/chat_headers/presentation/providers/chat_headers_repo_provider.dart';

final sideBarProvider = AsyncNotifierProvider<SideBarNotifier,ChatHeaders>(() {
  return SideBarNotifier();
},);
// ChatHeaders? _cachedChatHeaders;

class SideBarNotifier extends AsyncNotifier<ChatHeaders> {
    ChatHeadersRepo? chatHeadersRepo;

  @override
  FutureOr<ChatHeaders> build() async {
    // if (_cachedChatHeaders != null) {
    //   return _cachedChatHeaders!;
    // }
    chatHeadersRepo = ref.watch(chatHeadersRepoProvider);

    final result = await chatHeadersRepo!.getChatHeaders();
    return result.fold((failure) {
      throw Exception(failure.message);
    }, (chatHeaders) {
      // _cachedChatHeaders = chatHeaders;
      return chatHeaders;
    });
  }



  Future<void> refreshHeaders() async {

    state = const AsyncLoading();
    final result = await chatHeadersRepo!.getChatHeaders();
    result.fold(
          (failure) {
        state = AsyncError(failure.message, StackTrace.current);
      },
          (chatHeaders) {
        // _cachedChatHeaders = chatHeaders;
        state = AsyncData(chatHeaders);
      },
    );
  }

    Future<void> addNewHeader(HeadersData newHeader) async {
      final currentState = state;

      if (currentState is AsyncData<ChatHeaders>) {
        final chatHeaders = currentState.value;

        // Safely initialize list if null
        chatHeaders.data ??= [];

        // Add the new header
        chatHeaders.data!.add(newHeader);

        // Update the state with the modified ChatHeaders
        state = AsyncData(chatHeaders);
      } else {
        // Optional: handle cases where current state is loading/error
      }
    }
}