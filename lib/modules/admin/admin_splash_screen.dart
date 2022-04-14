import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/pages/admin_login_page/admin_login_page.dart';

import '../drivers/utils/user_defaults.dart';
import 'pages/admin_home_screen.dart';

class AdminSplashScreen extends StatefulWidget {
  static const id = "/AdminSplashScreen";

  const AdminSplashScreen({Key? key}) : super(key: key);

  @override
  _AdminSplashScreenState createState() => _AdminSplashScreenState();
}

class _AdminSplashScreenState extends State<AdminSplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () => {gotoRelevantScreenOnUserType()});
  }

  void gotoRelevantScreenOnUserType() {
    if (UserDefaults.getAdminSession() != null) {
      Get.toNamed(AdminHomeScreen.id);
    } else {
      Get.toNamed(AdminLoginPage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ),
    );
  }
}
