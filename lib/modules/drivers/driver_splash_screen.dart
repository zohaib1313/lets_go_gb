import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_home_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_onboarding_screen.dart';

import 'utils/user_defaults.dart';

class DriverSplashPage extends StatefulWidget {
  static const id = "/splash_screen";

  const DriverSplashPage({Key? key}) : super(key: key);

  @override
  _DriverSplashPageState createState() => _DriverSplashPageState();
}

class _DriverSplashPageState extends State<DriverSplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () => {gotoRelevantScreenOnUserType()});
  }

  void gotoRelevantScreenOnUserType() {
    if (UserDefaults.getDriverUserSession() != null) {
      Get.toNamed(DriverHomePage.id);
    } else {
      Get.to(() => const DriverOnBoardingScreen());
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
