import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/core/utils/api_end_points.dart';
import 'package:tour_guide/core/utils/services/network/api_service.dart';
import 'package:tour_guide/features/Chat/new_chat_page/data/model/chat_history.dart';
import 'package:tour_guide/features/Chat/new_chat_page/data/model/chat_response.dart';
import 'package:tour_guide/features/Chat/new_chat_page/data/repo/chat_repo.dart';

class ChatRepoImp extends ChatRepo{
  final String accessToken;
  final ApiService apiService;
  ChatRepoImp(this.apiService,this.accessToken);
  @override
  Future<Either<Failure, ChatHistory>> gelAllChats(chatID) async {
    try{
      final chats=await apiService.get(
        endPoint: ApiEndpoints.getAllMessages(chatID: chatID!),
        bearerToken: accessToken,
      );
      return right(ChatHistory.fromJson(chats));
    }catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(NewFailure(e.toString())); // Handle unexpected errors
    }
  }

  @override
  Future<Either<Failure, ChatResponse>> sendMessage({required String message, int? chatID}) async {
    try{
      Map<String,dynamic> parameters={"prompt":message,"chat_id":chatID};
      final result=await apiService.post(
        endPoint: ApiEndpoints.askAQuestion,
        bearerToken: accessToken,
        parameters: parameters,
      );

      return right(ChatResponse.fromJson(result));
    }catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(NewFailure(e.toString())); // Handle unexpected errors
    }
  }

}