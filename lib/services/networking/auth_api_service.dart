import 'package:home_in_app/models/Auth/register_model.dart';
import '../../controllers/Client/client_service.dart';
import '../../controllers/Client/timer_service.dart';
import '../../models/Auth/login_model.dart';
import '../../models/Auth/user_data_model.dart';
import 'api_config/api_methods.dart';

abstract class AuthApiService {
  Future<UserModel> postLoginApi(LoginModel loginModel);
  Future<UserModel> postRegisterApi(RegisterModel registerModel);
}

class AuthApiServiceImpWithHttp implements AuthApiService {
  final HttpClientService clientController;
  final TimerService timerService;

  AuthApiServiceImpWithHttp({
    required this.clientController,
    required this.timerService,
  });

  @override
  Future<UserModel> postLoginApi(LoginModel loginModel) async {
    clientController.reOpenClient();

    final response = await ApiMethods.postRequest<UserModel>(
      urlPath: 'auth/login',
      token: '',
      client: clientController.globalClient,
      timerService: timerService,
      isGlobalTimer: true,
      body: loginModel.toJson(),
      fromJson: UserModel.fromJson,
    );

    return response;
  }

  @override
  Future<UserModel> postRegisterApi(RegisterModel registerModel) async {
    clientController.reOpenClient();

    final response = await ApiMethods.postRequest<UserModel>(
      urlPath: 'auth/register',
      token: '',
      client: clientController.globalClient,
      timerService: timerService,
      isGlobalTimer: true,
      body: registerModel.toJson(),
      fromJson: UserModel.fromJson,
    );

    return response;
  }
}
