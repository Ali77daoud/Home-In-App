import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/Auth/auth_controller.dart';
import '../../../models/RequestInfo/request_info_model.dart';
import '../../../shared/constants/color_constants.dart';
import '../../../shared/constants/prefs_keys.dart';
import '../../../shared/global_functions/prefs.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/app_dialogs.dart';
import '../../../shared/widgets/text_widget.dart';
import 'components/info_widget.dart';

class InfoForDeveloperPage extends StatelessWidget {
  InfoForDeveloperPage({super.key});
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextWidget(
            text: 'Info For Developer'.tr,
            color: AppColors.primaryDark,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            maxline: 1,
          ),
          actions: [
            AppButton.normalButton(
              title: 'Delete All Data'.tr,
              height: 40,
              titleSize: 13,
              backgroundColor: AppColors.darkGrey,
              onPress: () async {
                AppDialogs.showConfirmationDialog(
                  context: context,
                  title: 'Are you sure you want delete to all data ?'.tr,
                  onConfirm: () async {
                    await authController.removeAllRequestsInfo();
                    Get.back();
                  },
                );
              },
            )
          ],
        ),
        body: GetBuilder<AuthController>(
          builder: (_) {
            final data = PrefsFunctions.getLocalStorageData(
              fromJson: RequestInfoModel.fromJson,
              key: PrefsKeys.requestsInfo,
            );
            return data.isEmpty
                ? const Center(
                    child: TextWidget(
                        text: 'No Data',
                        color: AppColors.blackDark,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.start,
                        maxline: 1),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InfoWidget(index: index);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
