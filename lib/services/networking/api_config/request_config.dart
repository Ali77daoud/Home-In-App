import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../controllers/Client/timer_service.dart';
import '../../../models/RequestInfo/request_info_model.dart';
import '../../../shared/constants/failure_messages.dart';
import '../../../shared/constants/prefs_keys.dart';
import '../../../shared/errors/exceptions.dart';
import 'package:http/http.dart';

import '../../../shared/global_functions/prefs.dart';

class RequestConfig {
  static int timeoutSeconds = 30;

  static Future<void> storeRequestInfo({
    required Uri uri,
    required String token,
    required String requestType,
    required String body,
    required Response response,
  }) async {
    final data = RequestInfoModel(
      url: uri.toString(),
      requestType: requestType,
      token: token,
      header: response.headers.toString(),
      body: body,
      response: jsonDecode(response.body).toString(),
    );

    await PrefsFunctions.setLocalStorageData(
      infoData: data,
      fromJson: RequestInfoModel.fromJson,
      key: PrefsKeys.requestsInfo,
      maxNumberOfData: 100,
    );
  }

  static T processResponse<T>({
    required Response response,
    required T Function(Map<String, dynamic>)? fromJson,
    required TimerService timerService,
    required bool isGlobalTimer,
    required String urlPath,
  }) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      debugPrint('2');
      final data = jsonDecode(response.body);
      debugPrint('api $urlPath succeeded');
      // Cancel the timer on successful response
      timerService.stopTimer(isGlobalTimer: isGlobalTimer);

      if (fromJson != null) {
        final responseData = fromJson(data);
        return responseData;
      } else {
        return data as T;
      }
    } else if (response.statusCode == 401) {
      debugPrint('Unauthorized');
      debugPrint(response.statusCode.toString());
      throw UnAuthorizedException(
          AppFailureMessages.unAuthorizedFailureMessage);
    } else if (response.statusCode == 501) {
      debugPrint('wrong entry data');
      throw WrongDataException(AppFailureMessages.wrongDataFailureMessage);
    } else {
      debugPrint('3');
      debugPrint(response.statusCode.toString());
      final data = jsonDecode(response.body);
      String? message = '';
      try {
        message = data['errors'][0]['message'];
        if (message == null || message == '') {
          message = AppFailureMessages.serverFailureMessage;
        }
      } catch (e) {
        message = AppFailureMessages.serverFailureMessage;
      }
      throw ServerException(message);
    }
  }
}
