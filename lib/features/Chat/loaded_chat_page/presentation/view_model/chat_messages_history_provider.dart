import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/shared/model/chat_model.dart';
// ChatPageProvider
final chatMessagesHistory= AsyncNotifierProviderFamily<ChatMessagesHistory,List<ChatModel>,int>(ChatMessagesHistory.new);

class ChatMessagesHistory extends FamilyAsyncNotifier<List<ChatModel>,int>{
  List<ChatModel> chatList=[];
  late final int chatID;
  @override
  Future<List<ChatModel>> build(int chatID) async {

    this.chatID=chatID;
    chatList.add(ChatModel("if I can only find a note that makes you understand", "so?"));
    chatList.add(ChatModel("just send the photo","but you are the one that can send a photo right now, a weak AI-Agent model I can't send or generate photos right now"));

    // chatList.add(ChatModel("so you are saying that I should send a photo so that you can analyze it and tell me which monument exists on it?","actually, I can do this, but I didn't say that I can do this"));
    // chatList.add(ChatModel("ok, here's the photo analyze it and tell me which monument resides on it","عمك ",imageLink: "https://i.ibb.co/MyPYM6F7/lol.png"));
    // chatList.add(ChatModel("what do you mean","Ramses II"));

     await Future.delayed(Duration(seconds: 3));
    return chatList;

  }

  Future<void> sendMessage(String message) async {
    ChatModel chatModel = ChatModel(message, "testinggg");

    // 1️⃣ Keep the old messages and optimistically add the new one
    state = AsyncData([
      ...(state.value ?? []),
      chatModel, // Add new message without triggering a loading state
    ]);

    try {
      // 2️⃣ Simulate sending message (backend request)
      await Future.delayed(Duration(seconds: 3));

      // 3️⃣ If the message is successfully sent, we can do nothing (state is already updated)
    } catch (e) {
      // 4️⃣ If sending fails, rollback the message
      state = AsyncData(state.value ?? []);
    }
  }



  Future<void> receiveMessage(String message)async {
    await Future.delayed(Duration(seconds: 3));

  }


}