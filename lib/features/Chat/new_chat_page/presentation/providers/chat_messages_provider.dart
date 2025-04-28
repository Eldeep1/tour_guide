import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/model/chat_headers_model.dart';
import 'package:tour_guide/features/Chat/chat_headers/presentation/providers/side_bar_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/data/model/chat_history.dart';
import 'package:tour_guide/features/Chat/new_chat_page/data/repo/chat_repo.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_repo_provider.dart';

final chatDataProvider = AsyncNotifierProvider<ChatDataNotifier, List<Data>>(
      () => ChatDataNotifier(),
);

class ChatDataNotifier extends AsyncNotifier<List<Data>> {

   ChatRepo? chatRepo;

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
    final result = await chatRepo!.gelAllChats(ref.read(chatIDProvider));
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
    final chatID = ref.read(chatIDProvider);
    final existing = state.value ?? [];
    final chatWasEmpty = existing.isEmpty; // <--- check BEFORE adding loading

    if(ref.read(sendingMessage)){
      return ;
    }
    if(state.value!.isNotEmpty) {
      scrollToTheEnd();
    }
    ref.read(sendingMessage.notifier).state=true;
    ref.read(sendMessageFormController).text="";

    // Add a loading placeholder
    final loadingMessage = Data(prompt: prompt, response: null);
    final withLoading = [...existing, loadingMessage];
    state = AsyncData(withLoading);

    print(chatID);
    final result = await chatRepo!.sendMessage(message: prompt, chatID: chatID);

    ref.read(sendingMessage.notifier).state=false;
    scrollToTheEnd();

    result.fold(
          (failure) {
            print(failure.message);
        // Replace the last item (the loading one) with an error message
        final errorMessage = Data(prompt: prompt, response: "Error: ${failure.message}");
        final updated = [...existing, errorMessage];
        state = AsyncData(updated);
      },
          (response) {
        ref.read(chatIDProvider.notifier).state = response.chatId;



        if (chatWasEmpty) {
          print("we are here");
          newHeader(response);
          ref.read(appBarHeaderProvider.notifier).state=response.chatTitle??"AI TOUR GUIDE";
        }
        print(response);
        print("this is the chat title : ${response.chatTitle}");
        // Replace the last item (loading) with actual response
        final successMessage = Data(prompt: prompt, response: response.response);
        final updated = [...existing, successMessage];
        state = AsyncData(updated);
        scrollToTheEnd();
      },
    );
  }
  void newHeader(response){
    print("we are here");
    print("new header!");

    final currentSideBar=ref.read(sideBarProvider.notifier);
    currentSideBar.addNewHeader(HeadersData(title: response.chatTitle,id: response.chatId));
  }


  void newChat() {
    // Clear the chat messages
    state = const AsyncData([]);
    // Reset chat ID to null (new session)
    ref.read(chatIDProvider.notifier).state = null;
    // Optionally reset app bar title
    ref.read(appBarHeaderProvider.notifier).state = "AI TOUR GUIDE";
    // Reset the input field as well if needed
    ref.read(sendMessageFormController).text = "";
  }

  void scrollToTheEnd() {
    print("we should scroll now");

    // Check if the user is at the bottom of the list already
    if (ref.read(scrollController).position.pixels ==
        ref.read(scrollController).position.maxScrollExtent) {
      return; // No need to scroll if we're already at the bottom
    }

    // If not at the bottom, scroll to the end
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(scrollController).jumpTo(ref.read(scrollController).position.maxScrollExtent);
    });
  }

}