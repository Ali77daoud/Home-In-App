import 'package:flutter/material.dart';
import 'package:home_in_app/shared/widgets/text_widget.dart';

import '../constants/color_constants.dart';

class BuildAppBarWidget extends StatelessWidget {
  final String title;

  const BuildAppBarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          /////////////////
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: title,
                  color: AppColors.blackDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
