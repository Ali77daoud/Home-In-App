import 'dart:async';
import 'package:dartz/dartz.dart';
import '../models/Settings/get_config_model.dart';
import '../models/Settings/set_config_model.dart';
import '../services/networking/settings_api_service.dart';
import '../shared/errors/failures.dart';
import '../shared/network_info/network_info.dart';
import 'repo_network_request.dart';

class SettingsRepository {
  final SettingsApiService settingsApiService;
  final NetworkInfo networkInfo;

  SettingsRepository({
    required this.settingsApiService,
    required this.networkInfo,
  });

  Future<Either<Failure, GetConfigModel>> getConfig({
    required String token,
  }) async {
    return RepoNetworkRequest.makeNetworkRequest<GetConfigModel>(
      networkInfo: networkInfo,
      request: () => settingsApiService.getConfigApi(token: token),
    );
  }

  Future<Either<Failure, SetConfigResponseModel>> setConfig({
    required String token,
    required SetConfigModel setConfigData,
  }) async {
    return RepoNetworkRequest.makeNetworkRequest<SetConfigResponseModel>(
      networkInfo: networkInfo,
      request: () => settingsApiService.setConfigApi(
        token: token,
        setConfigData: setConfigData,
      ),
    );
  }

  Future<Either<Failure, SetConfigResponseModel>> updateConfig({
    required String token,
    required SetConfigModel setConfigData,
  }) async {
    return RepoNetworkRequest.makeNetworkRequest<SetConfigResponseModel>(
      networkInfo: networkInfo,
      request: () => settingsApiService.updateConfigApi(
        token: token,
        setConfigData: setConfigData,
      ),
    );
  }
}
