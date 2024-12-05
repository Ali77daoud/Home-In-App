import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarWidgets {
  static void showFailureSnackBar({
    required String title,
    required String message,
    int seconds = 3,
  }) async {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 158, 15, 5),
        colorText: Colors.white,
        duration: Duration(seconds: seconds),
        icon: const Icon(Icons.error, color: Colors.white));
  }

  static void showSuccessSnackBar({
    required String title,
    required String message,
    int seconds = 3,
  }) async {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: seconds),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
