import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_in_app/shared/constants/validation_const.dart';
import 'package:iconly/iconly.dart';
import '../../controllers/Auth/auth_controller.dart';
import '../../models/Auth/login_model.dart';
import '../../routes/routes.dart';
import '../../shared/constants/color_constants.dart';
import '../../shared/constants/rendering_ids.dart';
import '../../shared/global_functions/prefs.dart';
import '../../shared/helpers/screen_size_utils.dart';
import '../../shared/widgets/app_buttons.dart';
import '../../shared/widgets/circle_indecator_widget.dart';
import '../../shared/widgets/custom_text_field.dart';
import 'components/auth_page_footer.dart';
import 'components/gradient_headre.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailKey = TextEditingController();
  final TextEditingController passKey = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AuthController>(
          id: RenderingIds.allAuthPageId,
          builder: (_) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      GradientHeader(
                        text1: 'LOGIN'.tr,
                        text2: 'To your account'.tr,
                      ),
                      /////////////////////////////////////////////
                      SizedBox(
                        height: ScreenSizeUtils.getHeightInPercent(context, 10),
                      ),
                      //////////////////////
                      buildBody(context)
                    ],
                  ),
                ),
                ///////////
                authController.isCircleShown
                    ? const CircleIndicatorWidget(
                        isBgWhite: false,
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSizeUtils.getWidthInPercent(
          context,
          10,
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              textInputType: TextInputType.text,
              controller: emailKey,
              hintText: 'Enter  Email'.tr,
              labelText: 'Email'.tr,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email should not be empty'.tr;
                }
                if (!RegExp(ValidationConst.validationEmail).hasMatch(value)) {
                  return 'Enter valid email'.tr;
                }
                return null;
              },
              prefixIcon: const Icon(IconlyBold.message),
              suffixIcon: null,
            ),
            ///////
            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 3),
            ),
            ////////////
            GetBuilder<AuthController>(
              id: RenderingIds.changeIsObscureId,
              builder: (_) {
                return CustomTextField(
                  textInputType: TextInputType.visiblePassword,
                  controller: passKey,
                  hintText: 'Enter  Password'.tr,
                  labelText: 'Password'.tr,
                  isObscure: authController.isObscure,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password should not be empty'.tr;
                    } else if (value.length < 8) {
                      return 'Password should not be less than 8 characters'.tr;
                    }
                    return null;
                  },
                  prefixIcon: const Icon(IconlyBold.lock),
                  suffixIcon: IconButton(
                    icon: Icon(authController.isObscure
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      authController.changeIsObscure();
                    },
                  ),
                );
              },
            ),

            //////////////
            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 10),
            ),
            ////////////
            AppButton.normalButton(
              backgroundColor: AppColors.blackDark,
              title: 'LOGIN'.tr,
              onPress: () async {
                if (formKey.currentState!.validate()) {
                  final loginData = LoginModel(
                    email: emailKey.text,
                    password: passKey.text,
                  );
                  await authController.login(loginModel: loginData);
                }
              },
            ),
            ///////
            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 2),
            ),
            // ////////////
            AppButton.normalButton(
              backgroundColor: AppColors.primaryDark,
              title: 'REGISTER GUEST'.tr,
              onPress: () async {
                await PrefsFunctions.setIsGuest(isGuest: true).then(
                  (value) {
                    Get.offNamed(Routes.mainPage);
                  },
                );
              },
            ),
            ///////
            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 8),
            ),
            // ////////////
            AuthPageFooter(
              text1: 'Dont have an account?'.tr,
              text2: 'SIGN UP'.tr,
              route: Routes.registerPage,
            ),
            ///////
            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 3),
            ),
            // ////////////
          ],
        ),
      ),
    );
  }
}
