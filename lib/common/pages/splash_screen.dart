import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/pages/login_page.dart';
import 'package:let_go_gb/modules/admin/pages/home_page/admin_home_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_home_page.dart';
import 'package:let_go_gb/modules/drivers/utils/app_user_roles.dart';
import 'package:let_go_gb/modules/users/pages/home_screen_user.dart';

import '../../modules/drivers/utils/user_defaults.dart';

class SplashScreen extends StatefulWidget {
  static const id = "/SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () => {gotoRelevantScreenOnUserType()});
  }

  void gotoRelevantScreenOnUserType() {
    String userType = UserDefaults.getUserType() ?? "";

    if (userType != "") {
      switch (userType) {
        case AppUserRoles.admin:
          if (UserDefaults.getAdminSession() != null) {
            Get.toNamed(AdminHomePage.id);
          }
          break;
        case AppUserRoles.driver:
          if (UserDefaults.getDriverUserSession() != null) {
            Get.toNamed(DriverHomePage.id);
          }
          break;
        case AppUserRoles.user:
          if (UserDefaults.getUserSession() != null) {
            Get.toNamed(UserHomeScreen.id);
          }
          break;
      }
    } else {
      Get.toNamed(LoginPage.id);
    }

    /* if (UserDefaults.getAdminSession() != null) {
      Get.toNamed(AdminHomePage.id);
    } else {
      Get.toNamed(AdminLoginPage.id);
    }*/
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
