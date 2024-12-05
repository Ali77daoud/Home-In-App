import 'package:get/get.dart';
import '../../providers/Auth_providers/login_provider.dart';
import '../../providers/Auth_providers/register_provider.dart';
import '../../providers/Settings_providers/get_config_provider.dart';
import '../../providers/Settings_providers/set_config_provider.dart';
import '../../providers/Settings_providers/update_config_provider.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/settings_repository.dart';
import '../../services/networking/auth_api_service.dart';
import '../../services/networking/settings_api_service.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    ///////////Auth///////////////////////////////////////////////////////////////
    Get.lazyPut<AuthApiService>(
      () => AuthApiServiceImpWithHttp(
        clientController: Get.find(),
        timerService: Get.find(),
      ),
    );

    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        networkInfo: Get.find(),
        authApiService: Get.find(),
      ),
    );
    Get.lazyPut<LoginProvider>(() => LoginProvider(Get.find()));
    Get.lazyPut<RegisterProvider>(() => RegisterProvider(Get.find()));
    ///////////Settings///////////////////////////////////////////////////////////////
    Get.lazyPut<SettingsApiService>(
      () => SettingsApiServiceImpWithHttp(
        clientController: Get.find(),
        timerService: Get.find(),
      ),
    );

    Get.lazyPut<SettingsRepository>(
      () => SettingsRepository(
        networkInfo: Get.find(),
        settingsApiService: Get.find(),
      ),
    );

    Get.lazyPut<GetConfigProvider>(() => GetConfigProvider(Get.find()));
    Get.lazyPut<SetConfigProvider>(() => SetConfigProvider(Get.find()));
    Get.lazyPut<UpdateConfigProvider>(() => UpdateConfigProvider(Get.find()));
  }
}
