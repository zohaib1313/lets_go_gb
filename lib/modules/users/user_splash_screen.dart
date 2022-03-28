import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/users/pages/home_screen_user.dart';

import '../drivers/utils/user_defaults.dart';
import 'pages/user_onboarding_screen.dart';

class UserSplashScreen extends StatefulWidget {
  static const id = "/UserSplashScreen";

  const UserSplashScreen({Key? key}) : super(key: key);

  @override
  _UserSplashScreenState createState() => _UserSplashScreenState();
}

class _UserSplashScreenState extends State<UserSplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () => {gotoRelevantScreenOnUserType()});
  }

  void gotoRelevantScreenOnUserType() {
    if (UserDefaults.getUserSession() != null) {
      Get.toNamed(UserHomeScreen.id);
    } else {
      Get.to(() => const UserOnBoardingScreen());
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
