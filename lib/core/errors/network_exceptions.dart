import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions implements Exception {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.canceledByUser() = CanceledByUser;

  const factory NetworkExceptions.badRequest(String reason) = BadRequest;
  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;
  const factory NetworkExceptions.forbidden() = Forbidden;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    int statusCode = response?.statusCode ?? 0;

    String errorMessage = _extractErrorMessage(response);

    switch (statusCode) {
      case 400:
        return NetworkExceptions.badRequest(errorMessage.isNotEmpty ? errorMessage : 'Bad request');
      case 401:
        return NetworkExceptions.unauthorizedRequest(errorMessage.isNotEmpty ? errorMessage : 'Unauthorized');
      case 403:
        return const NetworkExceptions.forbidden();
      case 404:
        return NetworkExceptions.notFound(errorMessage.isNotEmpty ? errorMessage : 'Not found');
      case 405:
        return const NetworkExceptions.methodNotAllowed();
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
        return NetworkExceptions.unprocessableEntity(errorMessage.isNotEmpty ? errorMessage : 'Invalid data');
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        int responseCode = statusCode;
        return NetworkExceptions.defaultError(
          errorMessage.isNotEmpty ? errorMessage : 'Received invalid status code: $responseCode',
        );
    }
  }

  static String _extractErrorMessage(Response? response) {
    try {
      final data = response?.data;
      Map<String, dynamic>? jsonData;

      if (data is String && data.isNotEmpty) {
        jsonData = jsonDecode(data) as Map<String, dynamic>?;
      } else if (data is Map<String, dynamic>) {
        jsonData = data;
      }

      if (jsonData != null) {
        if (jsonData['message'] != null) {
          return jsonData['message'].toString();
        }
        if (jsonData['error'] != null) {
          return jsonData['error'].toString();
        }
        if (jsonData['errorMessage'] != null) {
          return jsonData['errorMessage'].toString();
        }
      }
      return '';
    } catch (_) {
      return '';
    }
  }

  static NetworkExceptions getException(Object error) {
    if (error is NetworkExceptions) {
      return error;
    }

    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;

        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.unknown:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions =
                  NetworkExceptions.handleResponse(error.response);
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.unableToProcess();
              break;
            case DioExceptionType.connectionError:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    String errorMessage = '';
    networkExceptions.when(
      notImplemented: () {
        errorMessage = 'Not Implemented';
      },
      requestCancelled: () {
        errorMessage = 'Request Cancelled';
      },
      internalServerError: () {
        errorMessage = 'Internal Server Error';
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = 'Service unavailable';
      },
      methodNotAllowed: () {
        errorMessage = 'Method Not Allowed';
      },
      badRequest: (String message) {
        errorMessage = message;
      },
      unauthorizedRequest: (String error) {
        errorMessage = error;
      },
      unprocessableEntity: (String error) {
        errorMessage = error;
      },
      unexpectedError: () {
        errorMessage = 'Unexpected error occurred';
      },
      requestTimeout: () {
        errorMessage = 'Connection request timeout';
      },
      noInternetConnection: () {
        errorMessage = 'No internet connection';
      },
      conflict: () {
        errorMessage = 'Error due to a conflict';
      },
      sendTimeout: () {
        errorMessage = 'Send timeout in connection with API server';
      },
      unableToProcess: () {
        errorMessage = 'Unable to process the data';
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = 'Unexpected error occurred';
      },
      notAcceptable: () {
        errorMessage = 'Not acceptable';
      },
      forbidden: () {
        errorMessage = 'Forbidden';
      },
      canceledByUser: () {
        errorMessage = 'Canceled By The User';
      },
    );
    return errorMessage;
  }
}
