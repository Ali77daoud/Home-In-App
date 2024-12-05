import 'package:get/get.dart';
import 'package:home_in_app/views/Auth/register_page.dart';
import 'package:home_in_app/views/Main/main_page.dart';

import '../controllers/Auth/auth_binding.dart';
import '../views/Auth/login_page.dart';
import '../views/DeveloperInfo/info_for_developer/info_for_developer_page.dart';
import '../views/DeveloperInfo/info_for_developer/more_info_page.dart';
import '../views/Settings/preferred_settings_page.dart';
import '../views/Welcome/splash_page.dart';

class Routes {
  static const splashPage = '/splash_page';
  static const loginPage = '/login_page';
  static const registerPage = '/register_page';
  static const mainPage = '/main_page';
  static const infoForDeveloper = '/info_for_developer';
  static const moreInfoPage = '/more_info_page';
  static const preferredSettingsPage = '/preferred_settings_page';
}

class AppRoutes {
  static final routes = [
    GetPage(
      name: Routes.splashPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.loginPage,
      page: () => LoginPage(),
      transition: Transition.fade,
      binding: AuthBinding(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.registerPage,
      page: () => RegisterPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    /////////App Routes////////////////
    GetPage(
        name: Routes.mainPage,
        page: () => MainPage(),
        transitionDuration: const Duration(milliseconds: 0),
        bindings: [
          AuthBinding(),
        ]),
    ///////////
    GetPage(
      name: Routes.infoForDeveloper,
      page: () => InfoForDeveloperPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    ///////////
    GetPage(
      name: Routes.moreInfoPage,
      page: () => MoreInfoPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    ///////////
    GetPage(
      name: Routes.preferredSettingsPage,
      page: () => PreferredSettingsPage(),
      transition: Transition.fade,
      binding: AuthBinding(),
      transitionDuration: const Duration(milliseconds: 500),
    )
  ];
}
