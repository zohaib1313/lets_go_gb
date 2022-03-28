import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/signup_model.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_user_roles.dart';

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

  ///driver///////////////////////////////////////////////////////////////

  static void saveDriverSession(DriverUserModel signInModel) async {
    String user = json.encode(signInModel.toMap());
    getPref().then((value) => value..setString(AppUserRoles.driver, user));
    if (kDebugMode) {
      printWrapped("user session saved type=  ${user}");
      printWrapped(user.toString());
    }
  }

  static DriverUserModel? getDriverUserSession() {
    DriverUserModel? user;
    if (sharedPreferences!.getString(AppUserRoles.driver) != null) {
      Map<String, dynamic> json =
          jsonDecode(sharedPreferences!.getString(AppUserRoles.driver)!);
      user = DriverUserModel.fromMap(json);
    }
    return user;
  }
}
