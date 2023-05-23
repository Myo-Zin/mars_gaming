import 'package:dio/dio.dart';

import 'failure.dart';

class DioException implements Exception {
  late Failure failure;

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        failure = Failure("Request to API server was cancelled");
        break;
      case DioErrorType.connectTimeout:
        failure = Failure("Connection timeout with API server");
        break;
      case DioErrorType.other:
        failure = Failure("No internet connection");
        break;
      case DioErrorType.receiveTimeout:
        failure = Failure("Receive timeout in connection with API server");
        break;
      case DioErrorType.response:
        failure = _handleError(dioError.response!);
        break;
      case DioErrorType.sendTimeout:
        failure = Failure("Send timeout in connection with API server");
        break;
      default:
        failure = Failure("Something went wrong");
        break;
    }
  }

  Failure _handleError(Response response) {
    final isAuthError =
        response.data?.toString().contains("Route [login] not defined");
    if (isAuthError == true) {
      return Failure(
        "Authorization Error! Please login again.",
        reason: FailureReason.authError,
      );
    } else {
      try {
        final msg = response.data?["message"];
        if(msg == null){
          return Failure(response.data?["success"]);
        }
        return Failure(msg ?? "Oops something went wrong");
      } catch (e) {
        return Failure(response.data.toString());
      }
    }
  }

  @override
  String toString() => failure.message;
}
