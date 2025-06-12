import 'package:dartz/dartz.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/features/chat/new_chat_page/data/model/chat_history.dart';
import 'package:tour_guide/features/chat/new_chat_page/data/model/chat_request.dart';
import 'package:tour_guide/features/chat/new_chat_page/data/model/chat_response.dart';


abstract class ChatRepo {
  //1. get all messages
  //2. send message
  //3.
  Future<Either<Failure,ChatHistory>> gelAllChats(chatID);

  Future<Either<Failure,ChatResponse>> sendMessage({
    required  ChatRequest chatRequest
});
}