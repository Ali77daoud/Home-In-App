import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/Auth/auth_controller.dart';
import '../../../models/Settings/set_config_model.dart';
import '../../../shared/constants/color_constants.dart';
import '../../../shared/constants/rendering_ids.dart';
import '../../../shared/constants/settings_constants.dart';
import '../../../shared/global_functions/prefs.dart';
import '../../../shared/helpers/screen_size_utils.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/text_widget.dart';
import 'select_settings_widget.dart';

class PreferredSettings extends StatelessWidget {
  PreferredSettings({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !authController.isSetConfigCircleShown,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenSizeUtils.getHeightInPercent(context, 2),
              ),
              ////////////////////////
              buildPageHeader(),
              ////////////////////////
              SizedBox(
                height: ScreenSizeUtils.getHeightInPercent(context, 15),
              ),
              ////////////////////////
              GetBuilder<AuthController>(
                id: RenderingIds.changeLangId,
                builder: (_) {
                  return SelectSettingsWidget(
                    settings: authController.languages,
                    selectedSettings:
                        authController.currentLang == SettingsConstants.ara
                            ? SettingsConstants.arabic
                            : SettingsConstants.english,
                    title: 'Language'.tr,
                    icon: Icons.language,
                    iconColor: const Color.fromARGB(255, 8, 30, 102),
                    onChanged: (value) async {
                      if (value == SettingsConstants.arabic) {
                        await authController
                            .changeLanguage(SettingsConstants.ara);
                      } else {
                        await authController
                            .changeLanguage(SettingsConstants.ene);
                      }
                    },
                  );
                },
              ),

              ////////////////////////
              SizedBox(
                height: ScreenSizeUtils.getHeightInPercent(context, 2),
              ),
              ////////////////////////
              GetBuilder<AuthController>(
                id: RenderingIds.changeCurrencyId,
                builder: (_) {
                  return SelectSettingsWidget(
                    settings: authController.currencies,
                    selectedSettings: authController.currentCurrency,
                    title: 'Currency'.tr,
                    iconColor: const Color.fromARGB(255, 2, 103, 49),
                    icon: Icons.money,
                    onChanged: (value) async {
                      await authController.changeCurrency(value!);
                    },
                  );
                },
              ),
              ////////////////////////
              SizedBox(
                height: ScreenSizeUtils.getHeightInPercent(context, 20),
              ),
              /////////////////////////////
              authController.isSetConfigCircleShown
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton.normalButton(
                      backgroundColor: AppColors.blackDark,
                      title: PrefsFunctions.getIsSetConfig()
                          ? 'Start'.tr
                          : 'Update'.tr,
                      onPress: () async {
                        final setConfigData = SetConfigModel(
                          locale: authController.currentLang,
                          currency: authController.currentCurrency ==
                                  SettingsConstants.aed
                              ? 0
                              : 1,
                        );
                        if (PrefsFunctions.getIsSetConfig()) {
                          await authController.setConfig(
                            token: PrefsFunctions.getToken() ?? '',
                            setConfigData: setConfigData,
                          );
                        } else {
                          await authController.updateConfig(
                            token: PrefsFunctions.getToken() ?? '',
                            setConfigData: setConfigData,
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Personalize your experience'.tr,
          color: AppColors.darkGrey,
          fontSize: 23,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.start,
          maxline: 1,
        ),
        ///////////////////////
        TextWidget(
          text: 'Select your preferred settings'.tr,
          color: AppColors.grey,
          fontSize: 17,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.start,
          maxline: 1,
        ),
      ],
    );
  }
}
