import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import 'text_widget.dart';

class AppButton {
  static normalButton({
    required String title,
    VoidCallback? onPress,
    Color backgroundColor = AppColors.darkGrey,
    Color titleColor = Colors.white,
    double titleSize = 15,
    bool shadow = true,
    double height = 50,
    double width = double.infinity,
    double radius = 10,
  }) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: shadow
              ? const [
                  BoxShadow(color: AppColors.lightGray, blurRadius: 5),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: TextWidget(
            text: title,
            color: titleColor,
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            minFontSize: 8,
            maxline: 1,
            height: 2,
          ),
        ),
      ),
    );
  }
}
