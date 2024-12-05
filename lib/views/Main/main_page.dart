import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_in_app/routes/routes.dart';

import '../../controllers/Auth/auth_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await authController.logOut();
                  },
                  child: Container(
                    width: 80,
                    height: 50,
                    color: Colors.red,
                  ),
                ),
                //////////////////
                const SizedBox(
                  width: 10,
                ),
                //////////////////
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.preferredSettingsPage);
                  },
                  child: Container(
                    width: 80,
                    height: 50,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
