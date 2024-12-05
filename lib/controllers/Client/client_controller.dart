import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HttpClientController extends GetxController {
  late http.Client _globalClient;
  late http.Client _secondaryClient;

  http.Client get globalClient => _globalClient;
  http.Client get secondaryClient => _secondaryClient;

  @override
  void onInit() {
    super.onInit();
    _globalClient = http.Client();
    _secondaryClient = http.Client();
    debugPrint('init Clients');
  }

  @override
  void onClose() {
    closeGlobalClient();
    closeSecondaryClient();
    super.onClose();
  }

  void closeGlobalClient() {
    _globalClient.close();
    debugPrint('closeGlobalClient');
  }

  void reOpenGlobalClient() {
    _globalClient = http.Client();
    debugPrint('reOpenGlobalClient');
  }

  void closeSecondaryClient() {
    _secondaryClient.close();
    debugPrint('closeSecondaryClient');
  }

  void reOpenSecondaryClient() {
    _secondaryClient = http.Client();
    debugPrint('reOpenSecondaryClient');
  }
}
