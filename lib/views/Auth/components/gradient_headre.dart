import 'package:flutter/material.dart';
import '../../../shared/constants/color_constants.dart';
import '../../../shared/helpers/screen_size_utils.dart';
import '../../../shared/widgets/text_widget.dart';

class GradientHeader extends StatelessWidget {
  final String text1;
  final String text2;
  const GradientHeader({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSizeUtils.getHeightInPercent(context, 30),
      width: ScreenSizeUtils.getWidthInPercent(context, 100),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.blackDark, AppColors.primaryDark],
            stops: [0, 1],
            end: Alignment.topRight,
            begin: Alignment.bottomLeft),
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(200),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(
              left: ScreenSizeUtils.getWidthInPercent(context, 20),
              right: ScreenSizeUtils.getWidthInPercent(context, 25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: text1,
                color: AppColors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                maxline: 1,
              ),
              /////////////
              TextWidget(
                text: text2,
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                maxline: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
