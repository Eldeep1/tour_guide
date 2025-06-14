import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/features/chat/chat_headers/data/model/chat_headers_model.dart';
import 'package:tour_guide/features/chat/chat_headers/presentation/providers/side_bar_provider.dart';
import 'package:tour_guide/features/chat/new_chat_page/data/model/chat_history.dart';
import 'package:tour_guide/features/chat/new_chat_page/data/model/chat_response.dart';
import 'package:tour_guide/features/chat/new_chat_page/data/repo/chat_repo.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/chat_repo_provider.dart';

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

    state = const AsyncLoading();
    int? chatID=ref.read(messageRequestProvider.notifier).state.chatID;
    final result = await chatRepo!.gelAllChats(chatID);
    result.fold(
          (failure) {
            return state = AsyncError(failure.message, StackTrace.current);
          },
          (messages) {
            return state = AsyncData(messages.data ?? []);
          },
    );
  }

   Future<void> sendMessage({
     required String prompt,
   }) async {

    final messageRequest=ref.read(messageRequestProvider);
    messageRequest.prompt=prompt;

    final requestCopy = messageRequest.copyWith(
      prompt: prompt,
      chatID: messageRequest.chatID,
      image: messageRequest.image,
      label: messageRequest.label,
    );

     final sendingNotifier = ref.read(sendingMessage.notifier);
     final appBarHeaderNotifier = ref.read(appBarHeaderProvider.notifier);

     final existing = state.value ?? [];
     final chatWasEmpty = existing.isEmpty;

     if (sendingNotifier.state ) {
       return;
     }

     if(prompt.trim().isEmpty&&messageRequest.image==null){
       return;
     }

     sendingNotifier.state = true;

     messageRequest.image=null;
     messageRequest.label=null;
     messageRequest.prompt=null;

    final loadingMessage = Data(prompt: prompt, response: null,byteImage: requestCopy.image?.bytes);
    final withLoading = [...existing, loadingMessage];
    state = AsyncData(withLoading);

    late final Either<Failure, ChatResponse> result;
    result = await chatRepo!.sendMessage(chatRequest: requestCopy);

     sendingNotifier.state = false;

     result.fold(
           (failure) {
         final errorMessage = Data(prompt: prompt, response: "Error: ${failure.message}",byteImage: requestCopy.image?.bytes);
         final updated = [...existing, errorMessage];
         state = AsyncData(updated);
       },
           (response) {


         if (chatWasEmpty) {
           messageRequest.chatID = response.chatId;
           newHeader(response);
           appBarHeaderNotifier.state = response.chatTitle ?? "AI TOUR GUIDE";
         }
         final successMessage = Data(prompt: prompt, response: response.response,byteImage: requestCopy.image?.bytes);
         final updated = [...existing, successMessage];
         state = AsyncData(updated);
       },
     );
   }

   void newHeader(response){
    final currentSideBar=ref.read(sideBarProvider.notifier);
    currentSideBar.addNewHeader(HeadersData(title: response.chatTitle,id: response.chatId));
  }


  void newChat() {
    // clear the chat messages
    state = const AsyncData([]);
    ref.read(messageRequestProvider.notifier).state.chatID = null;
    ref.read(appBarHeaderProvider.notifier).state = "AI TOUR GUIDE";
  }
}