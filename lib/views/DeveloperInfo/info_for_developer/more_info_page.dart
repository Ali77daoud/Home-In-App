import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/Auth/auth_controller.dart';
import '../../../models/RequestInfo/request_info_model.dart';
import '../../../shared/constants/color_constants.dart';
import '../../../shared/constants/prefs_keys.dart';
import '../../../shared/global_functions/prefs.dart';
import '../../../shared/widgets/text_widget.dart';

class MoreInfoPage extends StatelessWidget {
  MoreInfoPage({super.key});
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final data = PrefsFunctions.getLocalStorageData(
      fromJson: RequestInfoModel.fromJson,
      key: PrefsKeys.requestsInfo,
    );
    int index = authController.moreDeveloperInfoIndex;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextWidget(
            text: 'More Info'.tr,
            color: AppColors.primaryDark,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            maxline: 1,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.primaryDark)),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildInfoText(
                      data[index],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoText(RequestInfoModel data) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          fontFamily: 'Tajawal',
        ),
        children: <TextSpan>[
          const TextSpan(
              text: 'Url : ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: '${data.url}\n\n',
          ),
          const TextSpan(
              text: 'Request : ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: '${data.requestType}\n\n',
          ),
          const TextSpan(
              text: 'Token : ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: '${data.token}\n\n',
          ),
          const TextSpan(
              text: 'Headers : ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: '${data.header}\n\n',
          ),
          const TextSpan(
              text: 'Body : ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: '${data.body}\n\n',
          ),
          const TextSpan(
              text: 'Response : ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: data.response,
          ),
        ],
      ),
    );
  }
}
