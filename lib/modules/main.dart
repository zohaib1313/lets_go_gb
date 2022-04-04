import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/users/user_application.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  await UserDefaults.getPref();

  //runApp(const DriverApplication());
  runApp(const UserApplication());
}
