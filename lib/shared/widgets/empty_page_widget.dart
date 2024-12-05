import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../helpers/responsive.dart';
import '../helpers/screen_size_utils.dart';
import 'app_buttons.dart';
import 'text_widget.dart';

class EmptyPageWidget extends StatelessWidget {
  final Function()? onTry;
  const EmptyPageWidget({super.key, required this.onTry});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: ScreenSizeUtils.getHeightInPercent(context, 3),
          ),
          /////////////////////////////////////////////
          Image.asset(
            'assets/pictures/empty-data.png',
            fit: BoxFit.cover,
            width: Responsive.isMobile(context) ? 250 : 200,
          ),
          //////////
          SizedBox(
            height: ScreenSizeUtils.getHeightInPercent(
                context, Responsive.isMobile(context) ? 8 : 2),
          ),
          /////////////////////////////////////////////
          TextWidget(
              text:
                  '${'There Is No Data To Display Now'.tr}\n${'Try Again'.tr}',
              color: AppColors.blackDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              maxline: 3),
          //////////
          SizedBox(
            height: ScreenSizeUtils.getHeightInPercent(
                context, Responsive.isMobile(context) ? 7 : 2),
          ),
          /////////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: AppButton.normalButton(
                height: 50,
                width: double.infinity,
                title: 'Try Again'.tr,
                backgroundColor: AppColors.primaryDark,
                shadow: false,
                titleColor: AppColors.white,
                onPress: onTry),
          ),
          //////////
          SizedBox(
            height: ScreenSizeUtils.getHeightInPercent(context, 8),
          ),
          ////////////
        ],
      ),
    );
  }
}
