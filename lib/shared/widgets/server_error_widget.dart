import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_constants.dart';
import '../helpers/screen_size_utils.dart';
import 'app_buttons.dart';
import 'text_widget.dart';

class ServerErrorWidget extends StatelessWidget {
  final Function() onTap;

  const ServerErrorWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/pictures/no_connection.png',
          fit: BoxFit.cover,
          width: 250,
        ),
        //////////
        TextWidget(
            text: '${'Server Or Network Error'.tr}\n${'Try Again'.tr}',
            color: AppColors.blackDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            maxline: 2),
        /////////
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: AppButton.normalButton(
              height: 50,
              width: double.infinity,
              title: 'Try Again'.tr,
              backgroundColor: AppColors.primaryDark,
              shadow: false,
              titleColor: AppColors.white,
              onPress: onTap),
        ),
        //////////
        SizedBox(
          height: ScreenSizeUtils.getHeightInPercent(context, 8),
        ),
        ////////////
      ],
    );
  }
}
