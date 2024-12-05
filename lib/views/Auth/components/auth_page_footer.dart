import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constants/color_constants.dart';
import '../../../shared/widgets/text_widget.dart';

class AuthPageFooter extends StatelessWidget {
  final String text1, text2, route;
  const AuthPageFooter({
    super.key,
    required this.text1,
    required this.text2,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: text1,
          color: AppColors.primaryDark,
          fontSize: 14,
          minFontSize: 10,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
          maxline: 1,
        ),
        const SizedBox(
          width: 2,
        ),
        InkWell(
          onTap: () {
            Get.offNamed(route);
          },
          child: TextWidget(
            text: text2,
            color: AppColors.blackDark,
            fontSize: 14,
            minFontSize: 10,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            maxline: 1,
          ),
        ),
      ],
    );
  }
}
