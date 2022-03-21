import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sing_in/models/login_model.dart';

class UserDefaults {
  static SharedPreferences? sharedPreferences;

  setBoolValue(String key, bool value) async {
    final SharedPreferences sharedPreferences = await getPref();
    sharedPreferences.setBool(key, value);
  }

  setString(String key, String value) async {
    final SharedPreferences sharedPreferences = await getPref();
    sharedPreferences.setString(key, value);
  }

  static Future<SharedPreferences> getPref() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    return sharedPreferences!;
  }

  bool getBoolValue(String key, bool defaultValue) {
    if (sharedPreferences != null) {
      return sharedPreferences!.containsKey(key)
          ? sharedPreferences!.getBool(key)!
          : defaultValue;
    }
    return defaultValue;
  }

  String getStringValue(String key, String defaultValue) {
    if (sharedPreferences != null) {
      return sharedPreferences!.containsKey(key)
          ? sharedPreferences!.getString(key)!
          : defaultValue;
    }

    return defaultValue;
  }

  clearAll() {
    if (sharedPreferences != null) {
      sharedPreferences!.clear();
    }
  }

  static void setIntValue(String key, int value) {
    final SharedPreferences sharedPreferences = UserDefaults.sharedPreferences!;

    sharedPreferences.setInt(key, value);
  }

  static int getIntValue(String key, int defaultValue) {
    final SharedPreferences sharedPreferences = UserDefaults.sharedPreferences!;

    return sharedPreferences.getInt(key) ?? defaultValue;
  }

  //employer, applicant,tutor

  static void saveUserSession(UserModel signInModel) async {
    String user = json.encode(signInModel.toJson());
    getPref().then((value) => value
      ..setString('userData', user));
    if (kDebugMode) {
      printWrapped("user session saved type=  ${user}");
      printWrapped(user.toString());
    }
  }

  static String? getUserType() {
    return sharedPreferences?.getString('type');
  }

  static String? getToken() {
    return sharedPreferences?.getString('ApiToken');
  }

  static setApiToken(String value) {
    return sharedPreferences?.setString('ApiToken', value);
  }

  static UserModel? getUserSession() {
    UserModel? user;
    if (sharedPreferences!.getString('userData') != null) {
      Map<String, dynamic> json =
          jsonDecode(sharedPreferences!.getString('userData')!);
      user = UserModel.fromJson(json);

      printWrapped(user.toString());
    }
    return user;
  }
}
