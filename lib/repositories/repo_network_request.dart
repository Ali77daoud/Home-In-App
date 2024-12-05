import 'package:dartz/dartz.dart';
import '../shared/constants/failure_messages.dart';
import '../shared/errors/failures.dart';
import '../shared/handling_errors/request_error_handling.dart';
import '../shared/network_info/network_info.dart';

class RepoNetworkRequest {
  static Future<Either<Failure, T>> makeNetworkRequest<T>({
    required Future<T> Function() request,
    required NetworkInfo networkInfo,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await request();
        return Right(response);
      } catch (e) {
        return await RequestErrorHandling.handle(
          exception: e,
          networkInfo: networkInfo,
        );
      }
    } else {
      return Left(
          OfflineFailure(message: AppFailureMessages.offlineFailureMessage));
    }
  }

  static Future<Either<Failure, Unit>> makeNetworkRequestUnit({
    required Future<void> Function() request,
    required NetworkInfo networkInfo,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await request();
        return const Right(unit);
      } catch (e) {
        return await RequestErrorHandling.handle(
          exception: e,
          networkInfo: networkInfo,
        );
      }
    } else {
      return Left(
          OfflineFailure(message: AppFailureMessages.offlineFailureMessage));
    }
  }
}
