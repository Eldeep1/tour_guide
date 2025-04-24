import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tour_guide/core/errors/failure.dart';
import 'package:tour_guide/core/utils/api_end_points.dart';
import 'package:tour_guide/core/utils/services/network/api_service.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/model/chat_headers_model.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/repo/chat_headers_repo.dart';

class ChatHeadersRepoImp extends ChatHeadersRepo {
  final ApiService apiService;
  final String accessToken;

  ChatHeadersRepoImp(this.apiService, this.accessToken);

  @override
  Future<Either<Failure, ChatHeaders>> getChatHeaders() async {
    print("we are fetching the request....");
    try {
      final result = await apiService.get(
          endPoint: ApiEndpoints.getAllChats,
          bearerToken: accessToken
      );
      return right(ChatHeaders.fromJson(result));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(NewFailure(e.toString())); // Handle unexpected errors
    }
  }
}