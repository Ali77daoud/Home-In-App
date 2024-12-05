import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/json_serializable.dart';
import '../constants/settings_constants.dart';
import '../constants/prefs_keys.dart';

class PrefsFunctions {
  static SharedPreferences prefs = Get.find<SharedPreferences>();

  static Future<void> reloadPrefs() async {
    await prefs.reload();
  }

  static Future<void> setLanLocal({required String lanLocal}) async {
    await prefs.setString(PrefsKeys.lang, lanLocal);
  }

  static String getLanLocal() {
    String lanLocal = prefs.getString(PrefsKeys.lang) ?? SettingsConstants.ene;

    return lanLocal;
  }

  static Future<void> setCurrencyLocal({required String currency}) async {
    await prefs.setString(PrefsKeys.currency, currency);
  }

  static String getCurrencyLocal() {
    String currency =
        prefs.getString(PrefsKeys.currency) ?? SettingsConstants.aed;

    return currency;
  }

  static Future<void> setIsGuest({required bool isGuest}) async {
    await prefs.setBool(PrefsKeys.isGuest, isGuest);

    debugPrint(isGuest.toString());
  }

  static bool getIsGuest() {
    bool isGuest = prefs.getBool(PrefsKeys.isGuest) ?? false;

    debugPrint('isGuest :  ${isGuest.toString()}');
    return isGuest;
  }

  static Future<void> setToken({required String token}) async {
    await prefs.setString(PrefsKeys.token, token);
  }

  static String? getToken() {
    String? token = prefs.getString(PrefsKeys.token);

    return token;
  }

  static Future<void> setIsLoggedIn({required bool isLoggedIn}) async {
    await prefs.setBool(PrefsKeys.isLoggedIn, isLoggedIn);

    debugPrint(isLoggedIn.toString());
  }

  static bool getIsLoggedIn() {
    bool isLoggedIn = prefs.getBool(PrefsKeys.isLoggedIn) ?? false;

    debugPrint('isLoggedIn :  ${isLoggedIn.toString()}');
    return isLoggedIn;
  }

  static Future<void> setIsSetConfig({required bool isSetConfig}) async {
    await prefs.setBool(PrefsKeys.isSetConfig, isSetConfig);
  }

  static bool getIsSetConfig() {
    bool isSetConfig = prefs.getBool(PrefsKeys.isSetConfig) ?? false;

    return isSetConfig;
  }

  static Future<void> setMobilePhone({required String? mobilePhone}) async {
    await prefs.setString(PrefsKeys.mobilePhone, mobilePhone ?? 'Empty');
  }

  static String getMobilePhone() {
    String? mobilePhone = prefs.getString(PrefsKeys.mobilePhone) ?? 'Empty';

    return mobilePhone;
  }

  static Future<void> setName({required String? name}) async {
    await prefs.setString(PrefsKeys.name, name ?? 'Empty');
  }

  static String getName() {
    String? name = prefs.getString(PrefsKeys.name) ?? 'Empty';
    return name;
  }

  static Future<void> setEmail({required String? email}) async {
    await prefs.setString(PrefsKeys.email, email ?? 'Empty');
  }

  static String getEmail() {
    String? email = prefs.getString(PrefsKeys.email) ?? 'Empty';

    return email;
  }

  static Future<void> setLocalStorageData<T extends JsonSerializable>({
    required T infoData,
    required T Function(Map<String, dynamic>)? fromJson,
    required String key,
    int maxNumberOfData = 40,
  }) async {
    List<T> data = getLocalStorageData(fromJson: fromJson!, key: key);

    if (data.length >= maxNumberOfData) {
      data.removeAt(data.length - 1);
      data.insert(0, infoData);
    } else {
      data.insert(0, infoData);
    }

    var infoListToJson = data.map((e) => e.toJson()).toList();

    String encodedData = json.encode(infoListToJson);

    await prefs.setString(key, encodedData);
  }

  static List<T> getLocalStorageData<T extends JsonSerializable>({
    required T Function(Map<String, dynamic>)? fromJson,
    required String key,
  }) {
    final data = prefs.getString(key);

    if (data != null) {
      final decodedData = json.decode(data);
      List<T> infoListFromJson =
          List<T>.from(decodedData.map((e) => fromJson!(e)));

      return infoListFromJson;
    } else {
      return [];
    }
  }

  static Future<void> deleteLocalStorageData<T extends JsonSerializable>({
    required int index,
    required T Function(Map<String, dynamic>) fromJson,
    required String key,
  }) async {
    List<T> data = getLocalStorageData(fromJson: fromJson, key: key);

    data.removeAt(index);

    var infoListToJson = data.map((e) => e.toJson()).toList();

    String encodedData = json.encode(infoListToJson);

    await prefs.setString(key, encodedData);
  }

  static Future<void> deleteAllLocalStorageData({
    required String key,
  }) async {
    await prefs.remove(key);
  }

  static Future<void> deleteAllLocalStorageDataWithId({
    required String key,
    required int id,
  }) async {
    await prefs.remove(key);
  }
}
