import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../constants/failure_messages.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';
import '../network_info/network_info.dart';

class RequestErrorHandling {
  static Future<Either<Failure, T>> handle<T>({
    required Object exception,
    required NetworkInfo networkInfo,
    bool isClientCloseFailure = false,
  }) async {
    if (exception is ServerException) {
      debugPrint('//// ServerException ///// \n $exception');
      return left(
        ServerFailure(
          message: exception.toString(),
        ),
      );
    } else if (exception is UnAuthorizedException) {
      debugPrint('//// UnAuthorizedException ///// \n $exception');
      return left(
        UnAuthorizedFailure(
          message: exception.toString(),
        ),
      );
    } else if (exception is ClientException) {
      debugPrint('//// ClientException ///// \n $exception');
      if (await networkInfo.isConnected) {
        return isClientCloseFailure
            ? left(
                ClientCloseFailure(message: ''),
              )
            : left(
                UnExpectedFailure(
                    message: AppFailureMessages.unExpectedFailureMessage),
              );
      } else {
        return left(
            OfflineFailure(message: AppFailureMessages.offlineFailureMessage));
      }
    } else if (exception is TimeoutException) {
      debugPrint('//// TimeoutException ///// \n $exception');
      return left(
        OfflineFailure(message: AppFailureMessages.offlineFailureMessage),
      );
    } else if (exception is WrongDataException) {
      debugPrint('//// WrongDataException ///// \n $exception');
      return left(
        WrongDataFailure(
          message: exception.toString(),
        ),
      );
    } else {
      debugPrint('//// UnExpectedException ///// \n $exception');
      return left(
        UnExpectedFailure(message: AppFailureMessages.unExpectedFailureMessage),
      );
    }
  }
}
