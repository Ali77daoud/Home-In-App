import 'package:home_in_app/models/Settings/get_config_model.dart';
import '../../controllers/Client/client_service.dart';
import '../../controllers/Client/timer_service.dart';
import '../../models/Settings/set_config_model.dart';
import 'api_config/api_methods.dart';

abstract class SettingsApiService {
  Future<GetConfigModel> getConfigApi({
    required String token,
  });

  Future<SetConfigResponseModel> setConfigApi({
    required String token,
    required SetConfigModel setConfigData,
  });

  Future<SetConfigResponseModel> updateConfigApi({
    required String token,
    required SetConfigModel setConfigData,
  });
}

class SettingsApiServiceImpWithHttp implements SettingsApiService {
  final HttpClientService clientController;
  final TimerService timerService;

  SettingsApiServiceImpWithHttp({
    required this.clientController,
    required this.timerService,
  });

  @override
  Future<GetConfigModel> getConfigApi({
    required String token,
  }) async {
    clientController.reOpenSecondaryClient();

    final response = await ApiMethods.getRequest<GetConfigModel>(
      urlPath: 'config/get',
      token: token,
      client: clientController.secondaryClient,
      timerService: timerService,
      isGlobalTimer: false,
      fromJson: GetConfigModel.fromJson,
    );

    return response;
  }

  @override
  Future<SetConfigResponseModel> setConfigApi({
    required String token,
    required SetConfigModel setConfigData,
  }) async {
    clientController.reOpenClient();

    final response = await ApiMethods.postRequest<SetConfigResponseModel>(
      urlPath: 'config/set',
      token: token,
      client: clientController.globalClient,
      timerService: timerService,
      isGlobalTimer: true,
      body: setConfigData.toJson(),
      fromJson: SetConfigResponseModel.fromJson,
    );

    return response;
  }

  @override
  Future<SetConfigResponseModel> updateConfigApi({
    required String token,
    required SetConfigModel setConfigData,
  }) async {
    clientController.reOpenClient();

    final response = await ApiMethods.postRequest<SetConfigResponseModel>(
      urlPath: 'config/update',
      token: token,
      client: clientController.globalClient,
      timerService: timerService,
      isGlobalTimer: true,
      body: setConfigData.toJson(),
      fromJson: SetConfigResponseModel.fromJson,
    );

    return response;
  }
}
