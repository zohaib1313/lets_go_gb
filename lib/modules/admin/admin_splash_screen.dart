import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    Get.toNamed(AdminHomeScreen.id);
    /*  if (UserDefaults.getUserSession() != null) {
      Get.toNamed(UserHomeScreen.id);
    } else {
      Get.to(() => const UserOnBoardingScreen());
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
