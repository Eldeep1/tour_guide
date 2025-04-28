import 'package:dio/dio.dart';
enum ServerErrorType {
  network,
  authentication,
  timeout,
  server,
  client,
  unknown,
}

abstract class Failure {
  String message;

  Failure(this.message);
}
// Each DioExceptionType corresponds to a specific network-related issue:
// connectionTimeout: When the app fails to connect to the server within the set timeout duration.
// sendTimeout: When a request takes too long to send data.
// receiveTimeout: When the app takes too long to receive a response from the server.
// badCertificate: Placeholder for handling invalid SSL certificates (not yet implemented).
// badResponse: Placeholder for handling incorrect server responses (not yet implemented).
// cancel: When the request is manually canceled.
// connectionError: When there is no internet connection or network failure.
// unknown: A fallback for any unexpected errors.
class StorageFailure extends Failure{
  StorageFailure(super.message);

}
class ServerFailure extends Failure {
  final ServerErrorType type;

  ServerFailure(super.message, {this.type = ServerErrorType.unknown});

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          "Request timed out. Please check your internet connection.",
          type: ServerErrorType.timeout,
        );

      case DioExceptionType.connectionError:
        return ServerFailure(
          "No internet connection. Please connect to a network and try again.",
          type: ServerErrorType.network,
        );

      case DioExceptionType.cancel:
        return ServerFailure(
          "Request was cancelled. Please try again.",
          type: ServerErrorType.unknown,
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          "Invalid security certificate. Try a different network.",
          type: ServerErrorType.network,
        );
      case DioExceptionType.badResponse:
        try {
          final statusCode = e.response?.statusCode ?? 0;
          final data = e.response?.data;

          String message = "Something went wrong.";

          if (data is Map) {
            if (data.containsKey('detail')) {
              message = data['detail'].toString();
            } else if (data.containsKey('error')) {
              final errorData = data['error'];

              if (errorData is Map) {
                // Check if 'detail' exists inside 'error'
                if (errorData.containsKey('detail')) {
                  message = errorData['detail'].toString();
                } else {
                  // Otherwise, parse all entries normally
                  message = errorData.entries.map((entry) {
                    return "${entry.key}: ${entry.value}";
                  }).join("\n");
                }
              } else {
                message = errorData.toString();
              }
            } else if (data.containsKey('message')) {
              message = data['message'].toString();
            }
          } else if (data is String) {
            message = data;
          }

          if (statusCode >= 400 && statusCode < 500) {
            return ServerFailure(
              message,
              type: (statusCode == 401 || statusCode == 403)
                  ? ServerErrorType.authentication
                  : ServerErrorType.client,
            );
          } else if (statusCode >= 500) {
            return ServerFailure(
              "Server error occurred. Please try again later.",
              type: ServerErrorType.server,
            );
          }

          return ServerFailure(message, type: ServerErrorType.unknown);
        } catch (_) {
          return ServerFailure("Failed to parse server error.", type: ServerErrorType.unknown);
        }


      case DioExceptionType.unknown:
      return ServerFailure("An unexpected error occurred.", type: ServerErrorType.unknown);
    }
  }
}

class NewFailure extends Failure {
  NewFailure(super.message);
}
