import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_in_app/themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_bindings.dart';
import 'language/localization.dart';
import 'routes/routes.dart';
import 'shared/constants/color_constants.dart';
import 'shared/constants/settings_constants.dart';
import 'shared/global_functions/prefs.dart';

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /////////////////////////////////////
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences);
  //////////////////////////////////////////////////
  HttpOverrides.global = MyHttpOverrides();
  //////////////////////////////////////////////////
  // statusBarColor
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryDark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Home In',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      //for language
      locale: Locale(PrefsFunctions.getLanLocal()),
      fallbackLocale: const Locale(SettingsConstants.ene),
      translations: LocalizationApp(),
      ////
      getPages: AppRoutes.routes,
      initialRoute: Routes.splashPage,
      initialBinding: AppBinding(),
    );
  }
}
