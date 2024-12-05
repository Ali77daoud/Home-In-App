import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/Auth/auth_controller.dart';
import '../../../../models/RequestInfo/request_info_model.dart';
import '../../../../routes/routes.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/constants/prefs_keys.dart';
import '../../../../shared/global_functions/prefs.dart';
import '../../../../shared/widgets/text_widget.dart';

class InfoWidget extends StatelessWidget {
  final int index;
  final AuthController authController = Get.find<AuthController>();
  InfoWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final data = PrefsFunctions.getLocalStorageData(
      fromJson: RequestInfoModel.fromJson,
      key: PrefsKeys.requestsInfo,
    );
    return SizedBox(
      width: double.infinity,
      height: 360,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity,
                height: 350,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    border: Border.all(color: AppColors.primaryDark)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /////////////////////
                    buildInfoWidget(
                        title: 'URL : ', data: data[index].url, maxLine: 2),
                    /////////////////////
                    buildInfoWidget(
                        title: 'Request : ',
                        data: data[index].requestType,
                        maxLine: 1),
                    /////////////////////
                    buildInfoWidget(
                      title: 'Token : ',
                      data: data[index].token,
                      maxLine: 3,
                    ),
                    /////////////////////
                    buildInfoWidget(
                        title: 'Headers : ',
                        data: data[index].header,
                        maxLine: 3),
                    /////////////////////
                    buildInfoWidget(
                        title: 'Body : ', data: data[index].body, maxLine: 3),
                    /////////////////////
                    buildInfoWidget(
                      title: 'Response : ',
                      data: data[index].response,
                      maxLine: 3,
                    ),
                    /////////////////////
                    buildButtonsWidget(data[index])
                  ],
                ),
              ),
            ),
          ),
          ////////////////////////////////
          Positioned(
              top: -1,
              right: -4,
              child: Container(
                width: 20,
                height: 20,
                color: AppColors.white,
              )),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () async {
                await authController.removeRequestFromDeveloperInfo(index);
              },
              child: const Icon(
                Icons.disabled_by_default,
                size: 25,
              ),
            ),
          ),
          //////////////////////////////////
        ],
      ),
    );
  }

  Widget buildButtonsWidget(
    RequestInfoModel data,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                authController.moreDeveloperInfoIndex = index;
                Get.toNamed(Routes.moreInfoPage);
              },
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.blackDark,
                ),
                child: Center(
                  child: TextWidget(
                      text: 'More Info'.tr,
                      color: AppColors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                      maxline: 1),
                ),
              ),
            ),
          ),
          //////////////
          const SizedBox(
            width: 10,
          ),
          //////////////
          Expanded(
            child: InkWell(
              onTap: () async {},
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.blackDark,
                ),
                child: Center(
                  child: TextWidget(
                      text: 'Share'.tr,
                      color: AppColors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                      maxline: 1),
                ),
              ),
            ),
            //////////////////
          ),
        ],
      ),
    );
  }

  Widget buildInfoWidget({
    required String data,
    required String title,
    required int maxLine,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SizedBox(
        height: 45,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: title,
                color: AppColors.blackDark,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
                minFontSize: 11,
                maxline: 1,
              ),
              /////////////
              Expanded(
                child: TextWidget(
                  text: data,
                  color: AppColors.blackDark,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 11,
                  maxline: maxLine,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
