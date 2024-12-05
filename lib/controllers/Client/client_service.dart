import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HttpClientService extends GetxService {
  late http.Client _globalClient;
  late http.Client _secondaryClient;

  http.Client get globalClient => _globalClient;
  http.Client get secondaryClient => _secondaryClient;

  @override
  void onInit() {
    super.onInit();
    _globalClient = http.Client();
    _secondaryClient = http.Client();
    debugPrint('init Client');
  }

  @override
  void onClose() {
    closeClient();
    closeSecondaryClient();
    super.onClose();
  }

  void closeClient() {
    _globalClient.close();
    debugPrint('closeClient');
  }

  void reOpenClient() {
    _globalClient = http.Client();
    debugPrint('reopenClient');
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
