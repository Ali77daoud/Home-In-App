import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_in_app/shared/constants/rendering_ids.dart';
import 'package:iconly/iconly.dart';
import '../../controllers/Auth/auth_controller.dart';
import '../../models/Auth/register_model.dart';
import '../../routes/routes.dart';
import '../../shared/constants/color_constants.dart';
import '../../shared/constants/validation_const.dart';
import '../../shared/helpers/screen_size_utils.dart';
import '../../shared/widgets/app_buttons.dart';
import '../../shared/widgets/circle_indecator_widget.dart';
import '../../shared/widgets/custom_text_field.dart';
import 'components/auth_page_footer.dart';
import 'components/gradient_headre.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameKey = TextEditingController();
  final TextEditingController emailKey = TextEditingController();
  final TextEditingController passKey = TextEditingController();
  final TextEditingController confirmPassKey = TextEditingController();
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
                          text1: 'SIGN UP'.tr, text2: 'New account'.tr),
                      /////////////////////////////////////////////
                      SizedBox(
                        height: ScreenSizeUtils.getHeightInPercent(context, 5),
                      ),
                      //////////////////////
                      buildBody(context)
                    ],
                  ),
                ),
                ///////////
                authController.isCircleShown
                    ? const CircleIndicatorWidget()
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
          horizontal: ScreenSizeUtils.getWidthInPercent(context, 10)),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              textInputType: TextInputType.text,
              controller: nameKey,
              hintText: 'Enter  Name'.tr,
              labelText: 'Name'.tr,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name should not be empty'.tr;
                }
                return null;
              },
              prefixIcon: const Icon(IconlyBold.profile),
              suffixIcon: null,
            ),
            ///////
            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 2),
            ),
            ////////////
            CustomTextField(
              textInputType: TextInputType.text,
              controller: emailKey,
              hintText: 'Enter  Email'.tr,
              labelText: 'Email'.tr,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email should not be empty'.tr;
                } else if (!RegExp(ValidationConst.validationEmail)
                    .hasMatch(value)) {
                  return 'Enter valid email'.tr;
                }
                return null;
              },
              prefixIcon: const Icon(IconlyBold.message),
              suffixIcon: null,
            ),
            ///////
            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 2),
            ),
            ////////////
            GetBuilder<AuthController>(
              id: RenderingIds.changeIsObscureId,
              builder: (_) {
                return CustomTextField(
                  textInputType: TextInputType.visiblePassword,
                  controller: passKey,
                  isObscure: authController.isObscure,
                  hintText: 'Enter  Password'.tr,
                  labelText: 'Password'.tr,
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
                    icon: Icon(
                      authController.isObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      authController.changeIsObscure();
                    },
                  ),
                );
              },
            ),

            ///////
            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 2),
            ),
            ////////////
            GetBuilder<AuthController>(
              id: RenderingIds.changeIsObscureId,
              builder: (_) {
                return CustomTextField(
                  textInputType: TextInputType.visiblePassword,
                  controller: confirmPassKey,
                  isObscure: authController.isObscure,
                  hintText: 'Enter  Password'.tr,
                  labelText: 'Confirm Password'.tr,
                  validator: (value) {
                    if (passKey.text != value) {
                      return 'Enter the same password value'.tr;
                    }
                    return null;
                  },
                  prefixIcon: const Icon(IconlyBold.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      authController.isObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      authController.changeIsObscure();
                    },
                  ),
                );
              },
            ),
            //////////////

            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 6),
            ),
            ////////////
            AppButton.normalButton(
              backgroundColor: AppColors.blackDark,
              title: 'SIGN UP'.tr,
              onPress: () async {
                if (formKey.currentState!.validate()) {
                  final registerData = RegisterModel(
                    name: nameKey.text,
                    email: emailKey.text,
                    password: passKey.text,
                    passwordConfirmation: confirmPassKey.text,
                  );
                  authController.register(registerModel: registerData);
                }
              },
            ),
            ///////
            SizedBox(
              height: ScreenSizeUtils.getHeightInPercent(context, 5),
            ),
            // ////////////
            AuthPageFooter(
              text1: 'Already have an account?'.tr,
              text2: 'LOGIN'.tr,
              route: Routes.loginPage,
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
