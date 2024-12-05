import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';
import '../../shared/constants/color_constants.dart';
import '../../shared/global_functions/prefs.dart';
import '../../shared/helpers/screen_size_utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool selected = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      goToHomeScreen();
    });
  }

  void goToHomeScreen() async {
    if (PrefsFunctions.getIsLoggedIn() || PrefsFunctions.getIsGuest()) {
      if (PrefsFunctions.getIsSetConfig()) {
        Get.offNamed(Routes.preferredSettingsPage);
      } else {
        Get.offNamed(Routes.mainPage);
      }
    } else {
      Get.offNamed(Routes.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? AppColors.primaryDark : AppColors.blackDark,
          ),
        );
      },
    );
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //////////////////////////
              SizedBox(
                height: ScreenSizeUtils.getHeightInPercent(context, 25),
              ),
              ///////////////////////////
              Container(
                width: ScreenSizeUtils.getWidthInPercent(context, 70),
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/pictures/splash_img.png',
                      ),
                      fit: BoxFit.contain),
                ),
              ),
              //////////////////////////
              SizedBox(
                height: ScreenSizeUtils.getHeightInPercent(context, 5),
              ),
              ///////////////////////////
              spinkit,
            ],
          )),
    );
  }
}
