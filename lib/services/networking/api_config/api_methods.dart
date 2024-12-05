import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../controllers/Client/timer_service.dart';
import '../../../shared/constants/settings_constants.dart';
import '../../../shared/global_functions/prefs.dart';
import 'api_constants.dart';
import 'request_config.dart';

class ApiMethods {
  static Future<T> getRequest<T>({
    required String urlPath,
    required String token,
    required Client client,
    required TimerService timerService,
    required bool isGlobalTimer,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/api/${ApiConstants.version}/$urlPath');

    String lang = '';

    if (PrefsFunctions.getLanLocal() == SettingsConstants.ene) {
      lang = 'en';
    } else if (PrefsFunctions.getLanLocal() == SettingsConstants.ara) {
      lang = 'ae';
    } else {
      lang = 'en';
    }

    final Completer<Response> completer = Completer<Response>();

    try {
      timerService.startTimer(
        isGlobalTimer: isGlobalTimer,
        duration: Duration(seconds: RequestConfig.timeoutSeconds),
        callback: () {
          if (!completer.isCompleted) {
            client.close();
            completer.completeError(TimeoutException(
                'The connection has timed out! after ${RequestConfig.timeoutSeconds} seconds'));
          }
        },
      );

      final responseFuture = client.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'lang': lang,
          'Connection': 'keep-alive',
        },
      );
      // Complete the completer with the response
      responseFuture.then(
        (response) {
          if (!completer.isCompleted) {
            completer.complete(response);
          }
        },
      ).catchError(
        (error) {
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        },
      );

      final response = await completer.future;

      debugPrint('/////1///////');

      await RequestConfig.storeRequestInfo(
        uri: uri,
        token: token,
        requestType: 'GET',
        body: '',
        response: response,
      );

      return RequestConfig.processResponse<T>(
        response: response,
        fromJson: fromJson,
        timerService: timerService,
        isGlobalTimer: isGlobalTimer,
        urlPath: urlPath,
      );
    } finally {
      if (timerService.isTimerActive(isGlobalTimer: isGlobalTimer)) {
        timerService.stopTimer(isGlobalTimer: isGlobalTimer);
      }
      client.close();
    }
  }

  static Future<T> postRequest<T>({
    required String urlPath,
    required String? token,
    required Client client,
    required TimerService timerService,
    required bool isGlobalTimer,
    required Map<String, dynamic> body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/api/${ApiConstants.version}/$urlPath');

    String lang = '';

    if (PrefsFunctions.getLanLocal() == SettingsConstants.ene) {
      lang = 'en';
    } else if (PrefsFunctions.getLanLocal() == SettingsConstants.ara) {
      lang = 'ae';
    } else {
      lang = 'en';
    }

    final Completer<Response> completer = Completer<Response>();

    Map<String, String>? headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'lang': lang,
      'Connection': 'keep-alive',
    };
    if (token == null) {
      headers.remove('Authorization');
    }
    try {
      timerService.startTimer(
        isGlobalTimer: isGlobalTimer,
        duration: Duration(seconds: RequestConfig.timeoutSeconds),
        callback: () {
          if (!completer.isCompleted) {
            client.close();
            completer.completeError(
              TimeoutException(
                  'The connection has timed out! after ${RequestConfig.timeoutSeconds} seconds'),
            );
          }
        },
      );
      final responseFuture = client.post(
        uri,
        body: json.encode(body),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'lang': lang,
          'Connection': 'keep-alive',
        },
      );

      // Complete the completer with the response
      responseFuture.then(
        (response) {
          if (!completer.isCompleted) {
            completer.complete(response);
          }
        },
      ).catchError(
        (error) {
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        },
      );

      final response = await completer.future;
      debugPrint('/////1///////');

      await RequestConfig.storeRequestInfo(
        uri: uri,
        token: token ?? '',
        requestType: 'POST',
        body: body.toString(),
        response: response,
      );
      //////////////////////////////////////////////////////////////////
      return RequestConfig.processResponse<T>(
        response: response,
        fromJson: fromJson,
        timerService: timerService,
        isGlobalTimer: isGlobalTimer,
        urlPath: urlPath,
      );
    } finally {
      if (timerService.isTimerActive(isGlobalTimer: isGlobalTimer)) {
        timerService.stopTimer(isGlobalTimer: isGlobalTimer);
      }
      client.close();
    }
  }
}
