import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_in_app/views/Settings/components/preferred_settings.dart';
import '../../controllers/Auth/auth_controller.dart';
import '../../controllers/Client/client_service.dart';
import '../../controllers/Client/timer_service.dart';
import '../../shared/constants/rendering_ids.dart';
import '../../shared/global_functions/prefs.dart';
import '../../shared/handling_errors/handling_errors.dart';

class PreferredSettingsPage extends StatefulWidget {
  const PreferredSettingsPage({super.key});

  @override
  State<PreferredSettingsPage> createState() => _PreferredSettingsPageState();
}

class _PreferredSettingsPageState extends State<PreferredSettingsPage> {
  final AuthController authController = Get.find<AuthController>();
  final HttpClientService httpClientController = Get.find<HttpClientService>();
  final TimerService timerService = Get.find<TimerService>();

  @override
  void initState() {
    super.initState();
    //////////////
    if (!PrefsFunctions.getIsSetConfig()) {
      getAllData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (!PrefsFunctions.getIsSetConfig()) {
      httpClientController.closeSecondaryClient();
      timerService.stopTimer(isGlobalTimer: false);
    }
  }

  void getAllData() async {
    String token = PrefsFunctions.getToken() ?? '';

    await authController.getConfig(token: token);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0,
        ),
        body: GetBuilder<AuthController>(
          id: RenderingIds.settingsPageId,
          builder: (_) {
            return HandlingErrors.pageErrorHandling(
              isCircleShown: authController.isGetConfigCircleShown,
              isServerError: authController.isGetConfigNoInternetShown,
              onTapServerErrorTry: () {
                getAllData();
              },
              page: RefreshIndicator(
                onRefresh: () async {
                  getAllData();
                },
                child: PreferredSettings(),
              ),
            );
          },
        ),
      ),
    );
  }
}
