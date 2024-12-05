import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/Auth/auth_controller.dart';
import '../constants/failure_messages.dart';
import '../errors/failures.dart';
import '../widgets/circle_indecator_widget.dart';
import '../widgets/server_error_widget.dart';
import '../widgets/snackbar_widgets.dart';

final AuthController authController = Get.find<AuthController>();

class HandlingErrors {
  static void networkErrorrHandling({
    required Failure failure,
    required Function() hideCircleIndicator,
    required Function() showServerErrorPage,
    Function()? showEmptyLocalStoragePage,
    bool isShowMessage = true,
    bool isShowNoConnectionMessage = true,
  }) async {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        hideCircleIndicator();
        showServerErrorPage();
        isShowMessage
            ? SnackBarWidgets.showFailureSnackBar(
                title: 'Server Error'.tr,
                message: failure.message,
                seconds: 4,
              )
            : null;
        break;

      case const (OfflineFailure):
        hideCircleIndicator();
        showServerErrorPage();
        isShowNoConnectionMessage
            ? SnackBarWidgets.showFailureSnackBar(
                title: 'No Connection'.tr,
                message: failure.message,
              )
            : null;
        break;
      case const (WrongDataFailure):
        hideCircleIndicator();
        isShowMessage
            ? SnackBarWidgets.showFailureSnackBar(
                title: 'Wrong Data'.tr,
                message: failure.message,
              )
            : null;
        break;
      case const (ClientCloseFailure):
        break;
      default:
        hideCircleIndicator();
        showServerErrorPage();
        SnackBarWidgets.showFailureSnackBar(
          title: 'Unexpected error'.tr,
          message: AppFailureMessages.unExpectedFailureMessage,
        );
        break;
    }
  }

  ////////////////////////
  static Widget pageErrorHandling({
    required bool isServerError,
    required dynamic Function() onTapServerErrorTry,
    required bool isCircleShown,
    required Widget page,
  }) {
    return isCircleShown
        ? const CircleIndicatorWidget(
            isBgWhite: true,
          )
        : isServerError
            ? ServerErrorWidget(onTap: onTapServerErrorTry)
            : page;
  }
}
