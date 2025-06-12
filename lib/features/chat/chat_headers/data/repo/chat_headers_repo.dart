
import 'package:dartz/dartz.dart';
import 'package:tour_guide/core/errors/failure.dart' show Failure;
import 'package:tour_guide/features/chat/chat_headers/data/model/chat_headers_model.dart';

abstract class ChatHeadersRepo{
  Future<Either<Failure,ChatHeaders>> getChatHeaders();
}