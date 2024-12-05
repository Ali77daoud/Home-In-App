import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'controllers/Auth/auth_controller.dart';
import 'controllers/Client/client_service.dart';
import 'controllers/Client/timer_service.dart';
import 'shared/network_info/network_info.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(HttpClientService(), permanent: true);
    Get.put(TimerService(), permanent: true);
    Get.put(Connectivity(), permanent: true);
    Get.put<NetworkInfo>(NetworkInfoImpl(Get.find()), permanent: true);
    /////////////////////////////////////////////////////////////
    Get.put(AuthController(), permanent: true);
  }
}
