// import 'dart:async';
//
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tour_guide/constants.dart';
// import 'package:tour_guide/core/utils/services/network/api_service.dart';
// import 'package:tour_guide/features/Chat/shared/model/shit_model.dart';
//
// import '../widgets/messages.dart';
//
// final tmpNewMessagesProvider =
//     NotifierProvider<TmpMessageProvider, List<Widget>>(TmpMessageProvider.new);
//
// class TmpMessageProvider extends Notifier<List<Widget>> {
//   bool receiving = false;
//
//   String chatHeader="";
//    ApiService apiService=ApiService(Dio());
//
//   TextEditingController chatFormController = TextEditingController();
//   ScrollController pageScrollController = ScrollController();
// String? sessionId;
//
//   bool isImageExists = false;
//   @override
//   List<Widget> build() {
//     // TODO: implement build
//     return [];
//   }
//
//   void scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (pageScrollController.hasClients) {
//         pageScrollController.animateTo(
//           pageScrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//
//   Future<void> sendMessage(String? header) async {
//     String message = chatFormController.text;
//     String queryMessage="$chatHeader $message";
//     TmpMessage tmpMessage= TmpMessage(query: queryMessage,userId: "no one cares",sessionId: sessionId);
//
//     if (receiving) {
//       return;
//     }
//     if (message.isEmpty) {
//       return;
//     }
//
//     receiving = true;
//     chatFormController.clear();
//
//     // Step 1: Add a loading message
//     state = [
//       ...state,
//       promptMessageBuilder(message)
//     ];
//     state = [...state, answerMessageBuilder(message: "Loading Response",isLoading: true)];
//
//     scrollToBottom();
//     try {
//
//
//       await apiService.post(
//           endPoint: sendingMessageEndPoint,
//         parameters: tmpMessage.toJson(),
//         headers: {
//       "Content-Type": "application/json",
//       },
//       ).then((value) {
//         print(value);
//         receiveMessage(value["response"]);
//         sessionId=value["session_id"];
//
//         if(value["response"].isNotEmpty){
//           chatHeader="";
//
//         }
//         print(sessionId);
//       },);
//
//
//     } catch (e) {
//       print(e.toString());
//       final newMessages = [...state];
//       newMessages[newMessages.length - 1] = errorMessageBuilder(e.toString());
//       state = newMessages;
//       receiving=false;
//     }
//     scrollToBottom();
//
//   }
//
//   Future<void> receiveMessage(String? response) async {
//       final newMessages = [...state];
//       newMessages[newMessages.length - 1] = answerMessageBuilder(
//           message:"$response"
//       ); // Replace last message
//       state = newMessages;
//       receiving = false;
//   }
// }
