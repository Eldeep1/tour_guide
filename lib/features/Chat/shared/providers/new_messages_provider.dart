import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/messages.dart';

final newMessagesProvider =
    NotifierProvider<NewMessageProvider, List<Widget>>(NewMessageProvider.new);

class NewMessageProvider extends Notifier<List<Widget>> {
  bool receiving = false;

  TextEditingController chatFormController = TextEditingController();
  ScrollController pageScrollController = ScrollController();

  XFile? image;

  bool isImageExists = false;
  @override
  List<Widget> build() {
    // TODO: implement build
    return [];
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageScrollController.hasClients) {
        pageScrollController.animateTo(
          pageScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> sendMessage() async {
    String message = chatFormController.text;
    String? imageLink = image?.path;
    if (receiving) {
      return;
    }
    if (message.isEmpty && imageLink == null) {
      return;
    }

    receiving = true;
    chatFormController.clear();
    image = null;

    // Step 1: Add a loading message
    state = [
      ...state,
      promptMessageBuilder(message, isLoading: true)
    ];
    scrollToBottom();
    try {
      // Step 2: Simulate API call
      await Future.delayed(const Duration(seconds: 3));

      // Step 3: Replace the last loading message with the final sent message
      final newMessages = [...state];
      newMessages[newMessages.length - 1] = promptMessageBuilder(message); // Replace last message
      state = newMessages; // Update state properly

      // step 4: wait for the response
      receiveMessage();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> receiveMessage() async {
    //loading state...
    state = [...state, answerMessageBuilder(message: "Loading Response",isLoading: true)];
    scrollToBottom();
    try {
      await Future.delayed(const Duration(seconds: 3));
      final newMessages = [...state];
      newMessages[newMessages.length - 1] = answerMessageBuilder(
          message:
              "this response should be received from the weak agent model, just simulating the backend till we get a backend"); // Replace last message
      state = newMessages;
      receiving = false;
    } catch (e) {
      //
    }
  }
}
