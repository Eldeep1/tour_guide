import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/new_chat_page/data/model/chat_history.dart';
import 'package:tour_guide/features/Chat/new_chat_page/data/repo/chat_repo.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_repo_provider.dart';

final chatDataProvider = AsyncNotifierProvider<ChatDataNotifier, List<Data>>(
      () => ChatDataNotifier(),
);

class ChatDataNotifier extends AsyncNotifier<List<Data>> {

  late final ChatRepo chatRepo;

  @override
  FutureOr<List<Data>> build() {
    chatRepo=ref.watch(chatRepoProvider);
    state = const AsyncLoading();

    return [];

  }
  Future<void> fetchOldMessages() async {
    print("the chat id from the provider${ref.read(chatIDProvider)}");
    
    //1. delete old messages
    // state = const AsyncData([]);
    state = const AsyncLoading();
    final result = await chatRepo.gelAllChats(ref.read(chatIDProvider));
    result.fold(
          (failure) {
            print("no messssssssssssages");
            print(failure.message);
            return state = AsyncError(failure.message, StackTrace.current);
          },

          (messages) {
            print("we got the messsssagesss");
            print(messages.data![0].prompt);
            return state = AsyncData(messages.data ?? []);
          },
    );
  }

  Future<void> sendMessage({
    required String prompt,
  }) async {
    final chatID = ref.watch(chatIDProvider);
    final existing = state.value ?? [];

    // Add a loading placeholder
    final loadingMessage = Data(prompt: prompt, response: null);
    final withLoading = [...existing, loadingMessage];
    state = AsyncData(withLoading);

    print(chatID);
    final result = await chatRepo.sendMessage(message: prompt, chatID: chatID);

    result.fold(
          (failure) {
        // Replace the last item (the loading one) with an error message
        final errorMessage = Data(prompt: prompt, response: "Error: ${failure.message}");
        final updated = [...existing, errorMessage];
        state = AsyncData(updated);
      },
          (response) {
        ref.read(chatIDProvider.notifier).state = response.chatId;

        // Replace the last item (loading) with actual response
        final successMessage = Data(prompt: prompt, response: response.response);
        final updated = [...existing, successMessage];
        state = AsyncData(updated);
      },
    );
  }


}