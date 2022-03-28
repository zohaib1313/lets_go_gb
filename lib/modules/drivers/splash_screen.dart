import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_home_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/onboardin_screen.dart';
import 'package:let_go_gb/modules/drivers/utils/app_user_roles.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

import 'utils/user_defaults.dart';

class SplashScreen extends StatefulWidget {
  static const id = "splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => {
              if (UserDefaults.getDriverUserSession() != null)
                {
                  if (UserDefaults.getDriverUserSession()!.userRole ==
                      AppUserRoles.driver)
                    {Get.toNamed(DriverHomePage.id)}
                }
              else
                {Get.to(() => const OnBoardingScreen())}
            });
  }

  void gotoRelevantScreenOnUserType() {
    String userType = UserDefaults?.getUserType() ?? "";

    printWrapped(userType);

    if (userType.isNotEmpty) {
      switch (userType) {
      }
    } else {
      //  Navigator.of(myContext!).pushReplacementNamed(OnBoardingScreen.id);
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
