import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_in_app/shared/constants/color_constants.dart';

import '../../../shared/helpers/screen_size_utils.dart';
import '../../../shared/widgets/text_widget.dart';

class SelectSettingsWidget extends StatelessWidget {
  const SelectSettingsWidget({
    super.key,
    required this.settings,
    required this.selectedSettings,
    required this.onChanged,
    required this.title,
    required this.icon,
    required this.iconColor,
  });
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<String> settings;
  final String selectedSettings;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightGray,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: iconColor,
          ),
          /////////////////////////
          SizedBox(
            width: ScreenSizeUtils.getWidthInPercent(context, 4),
          ),
          /////////////////////////
          Expanded(
            child: TextWidget(
              text: title.tr,
              color: AppColors.darkGrey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              minFontSize: 14,
              maxline: 2,
            ),
          ),
          /////////////////////////
          const SizedBox(width: 10),
          /////////////////////////
          DropdownButton<String>(
            value: selectedSettings,
            icon: const Icon(Icons.keyboard_arrow_down_sharp),
            underline: const SizedBox.shrink(),
            onChanged: onChanged,
            items: settings.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: TextWidget(
                    text: value,
                    color: AppColors.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    minFontSize: 13,
                    maxline: 2,
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
