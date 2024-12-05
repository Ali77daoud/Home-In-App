import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_in_app/models/Auth/register_model.dart';
import 'package:home_in_app/shared/constants/rendering_ids.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Auth/login_model.dart';
import '../../models/Auth/user_data_model.dart';
import '../../models/RequestInfo/request_info_model.dart';
import '../../models/Settings/get_config_model.dart';
import '../../models/Settings/set_config_model.dart';
import '../../providers/Auth_providers/login_provider.dart';
import '../../providers/Auth_providers/register_provider.dart';
import '../../providers/Settings_providers/get_config_provider.dart';
import '../../providers/Settings_providers/set_config_provider.dart';
import '../../providers/Settings_providers/update_config_provider.dart';
import '../../routes/routes.dart';
import '../../shared/constants/settings_constants.dart';
import '../../shared/constants/prefs_keys.dart';
import '../../shared/constants/success_messages.dart';
import '../../shared/global_functions/prefs.dart';
import '../../shared/handling_errors/handling_errors.dart';
import '../../shared/widgets/snackbar_widgets.dart';

class AuthController extends GetxController {
  bool isCircleShown = false;
  bool isObscure = true;

  SharedPreferences prefs = Get.find<SharedPreferences>();

  int moreDeveloperInfoIndex = 0;

  late LoginProvider loginProvider = Get.find();
  late RegisterProvider registerProvider = Get.find();
  late GetConfigProvider getConfigProvider = Get.find();
  late SetConfigProvider setConfigProvider = Get.find();
  late UpdateConfigProvider updateConfigProvider = Get.find();

  UserDataModel? userData;
  GetConfigModel? getConfigData;
  SetConfigResponseModel? setConfigResponseData;

  ///////////////////
  void changeIsObscure() {
    isObscure = !isObscure;
    update([RenderingIds.changeIsObscureId]);
  }

/////////////////////////
  void showCircleIndicator() {
    if (isCircleShown == false) {
      isCircleShown = true;
      update([RenderingIds.allAuthPageId]);
    }
  }

////////////////////////////
  void hideCircleIndicator() {
    if (isCircleShown == true) {
      isCircleShown = false;
      update([RenderingIds.allAuthPageId]);
    }
  }

  Future<void> login({required LoginModel loginModel}) async {
    showCircleIndicator();
    final failureOrLogin = await loginProvider.call(loginModel);
    failureOrLogin.fold(
      (failure) {
        HandlingErrors.networkErrorrHandling(
            failure: failure,
            hideCircleIndicator: hideCircleIndicator,
            showServerErrorPage: () {});
      },
      (getUserData) async {
        userData = getUserData.data!;

        Future.wait([
          PrefsFunctions.setToken(token: userData!.token!),
          PrefsFunctions.setIsLoggedIn(isLoggedIn: true),
          PrefsFunctions.setName(name: userData!.name),
        ]);

        await authController.getConfig(token: userData!.token!);
        //////////////////////////////////////////////////////////////////
        hideCircleIndicator();
        Get.offAllNamed(Routes.mainPage);
        SnackBarWidgets.showSuccessSnackBar(
          title: AppSuccessMessages.loginSucceededMessage.tr,
          message: '',
        );
      },
    );
  }

  Future<void> register({required RegisterModel registerModel}) async {
    showCircleIndicator();
    final failureOrLogin = await registerProvider.call(registerModel);
    failureOrLogin.fold(
      (failure) {
        HandlingErrors.networkErrorrHandling(
            failure: failure,
            hideCircleIndicator: hideCircleIndicator,
            showServerErrorPage: () {});
      },
      (getUserData) async {
        userData = getUserData.data!;

        Future.wait([
          PrefsFunctions.setToken(token: userData!.token!),
          PrefsFunctions.setIsLoggedIn(isLoggedIn: true),
          PrefsFunctions.setName(name: userData!.name),
          PrefsFunctions.setIsSetConfig(isSetConfig: true),
        ]);
        hideCircleIndicator();
        Get.offAllNamed(Routes.preferredSettingsPage);
        SnackBarWidgets.showSuccessSnackBar(
          title: AppSuccessMessages.registerSucceededMessage.tr,
          message: '',
        );
      },
    );
  }

  //////////////////
  Future<void> logOut() async {
    await prefs.clear();
    await PrefsFunctions.setIsLoggedIn(isLoggedIn: false);
    await PrefsFunctions.setIsGuest(isGuest: false);
    /////////////////////////////////////
    Get.offAllNamed(Routes.loginPage);
  }

  //////////////////////////////////////////////
  bool isGetConfigCircleShown = false;
  bool isGetConfigNoInternetShown = false;

  bool isSetConfigCircleShown = false;

  void showGetConfigCircleIndicator() {
    if (isGetConfigCircleShown == false) {
      isGetConfigCircleShown = true;
      update([RenderingIds.settingsPageId]);
    }
  }

  void hideGetConfigCircleIndicator() {
    if (isGetConfigCircleShown == true) {
      isGetConfigCircleShown = false;
      update([RenderingIds.settingsPageId]);
    }
  }

/////////////////////////////////////
  void showGetConfigNoInternetPage() {
    if (isGetConfigNoInternetShown == false) {
      isGetConfigNoInternetShown = true;
      update([RenderingIds.settingsPageId]);
    }
  }

  void hideGetConfigNoInternetPage() {
    if (isGetConfigNoInternetShown == true) {
      isGetConfigNoInternetShown = false;
      update([RenderingIds.settingsPageId]);
    }
  }

  ///////////////////////////
  Future<void> getConfig({
    required String token,
  }) async {
    showGetConfigCircleIndicator();
    ////////////////////////////////////////
    final failureOrData = await getConfigProvider.call(token: token);

    failureOrData.fold(
      (failure) {
        HandlingErrors.networkErrorrHandling(
          failure: failure,
          hideCircleIndicator: hideGetConfigCircleIndicator,
          showServerErrorPage: showGetConfigNoInternetPage,
          isShowMessage: true,
          isShowNoConnectionMessage: true,
        );
      },
      (data) async {
        getConfigData = data;
        /////////////////////////////////////////
        await saveLanguage(data.data.locale);
        await saveCurrency(data.data.currency == 0
            ? SettingsConstants.aed
            : SettingsConstants.dollar);

        currentLang = data.data.locale;
        currentCurrency = data.data.currency == 0
            ? SettingsConstants.aed
            : SettingsConstants.dollar;

        debugPrint(data.data.locale);
        debugPrint(data.data.currency.toString());
        /////////////////////////////////////////
        hideGetConfigCircleIndicator();
        hideGetConfigNoInternetPage();
      },
    );
  }

  void showSetConfigCircleIndicator() {
    if (isSetConfigCircleShown == false) {
      isSetConfigCircleShown = true;
      update([RenderingIds.settingsPageId]);
    }
  }

  void hideSetConfigCircleIndicator() {
    if (isSetConfigCircleShown == true) {
      isSetConfigCircleShown = false;
      update([RenderingIds.settingsPageId]);
    }
  }

  Future<void> setConfig({
    required String token,
    required SetConfigModel setConfigData,
  }) async {
    showSetConfigCircleIndicator();
    final failureOrLogin = await setConfigProvider.call(
      token: token,
      setConfigData: setConfigData,
    );
    failureOrLogin.fold(
      (failure) {
        HandlingErrors.networkErrorrHandling(
          failure: failure,
          hideCircleIndicator: hideSetConfigCircleIndicator,
          showServerErrorPage: () {},
          isShowMessage: true,
          isShowNoConnectionMessage: true,
        );
      },
      (data) async {
        setConfigResponseData = data;
        /////////////////////////////////////////
        await saveLanguage(data.data.locale);
        await saveCurrency(data.data.currency == '0'
            ? SettingsConstants.aed
            : SettingsConstants.dollar);

        debugPrint(data.data.locale);
        debugPrint(data.data.currency);
        ///////////////////////////////////////
        hideSetConfigCircleIndicator();
        await PrefsFunctions.setIsSetConfig(isSetConfig: false);
        Get.offAllNamed(Routes.mainPage);
      },
    );
  }

  Future<void> updateConfig({
    required String token,
    required SetConfigModel setConfigData,
  }) async {
    showSetConfigCircleIndicator();
    final failureOrLogin = await updateConfigProvider.call(
      token: token,
      setConfigData: setConfigData,
    );
    failureOrLogin.fold(
      (failure) {
        HandlingErrors.networkErrorrHandling(
          failure: failure,
          hideCircleIndicator: hideSetConfigCircleIndicator,
          showServerErrorPage: () {},
          isShowMessage: true,
          isShowNoConnectionMessage: true,
        );
      },
      (data) async {
        setConfigResponseData = data;
        /////////////////////////////////////////
        await saveLanguage(data.data.locale);
        await saveCurrency(data.data.currency == '0'
            ? SettingsConstants.aed
            : SettingsConstants.dollar);

        debugPrint(data.data.locale);
        debugPrint(data.data.currency);
        ///////////////////////////////////////
        hideSetConfigCircleIndicator();
      },
    );
  }

  //for setting
  final List<String> languages = [
    SettingsConstants.english,
    SettingsConstants.arabic
  ];
  final List<String> currencies = [
    SettingsConstants.aed,
    SettingsConstants.dollar
  ];

  String currentLang = PrefsFunctions.getLanLocal();
  String currentCurrency = PrefsFunctions.getCurrencyLocal();

  Future<void> changeLanguage(String lang) async {
    if (currentLang == lang) {
      return;
    }
    currentLang = lang;

    update([RenderingIds.changeLangId]);
  }

  Future<void> saveLanguage(String lang) async {
    await PrefsFunctions.setLanLocal(lanLocal: lang).then(
      (value) async {
        await Get.updateLocale(
          Locale(
            lang,
          ),
        );
      },
    );
  }

  Future<void> changeCurrency(String currency) async {
    if (currentCurrency == currency) {
      return;
    }
    currentCurrency = currency;

    update([RenderingIds.changeCurrencyId]);
  }

  Future<void> saveCurrency(String currency) async {
    await PrefsFunctions.setCurrencyLocal(currency: currency);
  }

  //////////////////////////

  Future<void> removeRequestFromDeveloperInfo(int index) async {
    await PrefsFunctions.deleteLocalStorageData(
      index: index,
      fromJson: RequestInfoModel.fromJson,
      key: PrefsKeys.requestsInfo,
    );
    update();
  }

  Future<void> removeAllRequestsInfo() async {
    await PrefsFunctions.deleteAllLocalStorageData(
      key: PrefsKeys.requestsInfo,
    );
    update();
  }
}
