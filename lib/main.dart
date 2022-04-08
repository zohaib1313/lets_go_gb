import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:let_go_gb/common/Push_notifications_manager.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';

import 'modules/users/user_application.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}

const firebaseConfig = {
  "apiKey": "AIzaSyBAfrEGDzwbA5ei1gnKDvH3XNWIqEJvITY",
  "authDomain": "letsgogb-6eb5b.firebaseapp.com",
  "projectId": "letsgogb-6eb5b",
  "storageBucket": "letsgogb-6eb5b.appspot.com",
  "messagingSenderId": "756450874654",
  "appId": "1:756450874654:web:6775bbd6517870920ee50f"
};
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions.fromMap(firebaseConfig),
    );
    //await FirebaseCoreWeb().initializeApp();
  } else {
    await Firebase.initializeApp();
  }
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  await UserDefaults.getPref();
  await PushNotificationsManager().init();
/*  await PushNotificationsManager.sendMessage(
      toDeviceId: "toDeviceId", notificationModel: NotificationModel());*/
  //runApp(const DriverApplication());
  runApp(const UserApplication());
  //runApp(const AdminApplication());
}
