import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/users/pages/login_user_screen.dart';

import '../../drivers/dashboard/pages/on_boarding_views.dart';

class UserOnBoardingScreen extends StatefulWidget {
  const UserOnBoardingScreen({Key? key}) : super(key: key);
  static const id = "/UserOnBoardingScreen";

  @override
  _UserOnBoardingScreenState createState() => _UserOnBoardingScreenState();
}

class _UserOnBoardingScreenState extends State<UserOnBoardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      rawPages: rawPages,

      // freeze: true,
      controlsMargin: const EdgeInsets.all(10),
      onDone: () {
        Get.toNamed(UserLoginScreen.id);
      },
      onSkip: () {
        Get.toNamed(UserLoginScreen.id);
      },
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: AppTextStyles.textStyleNormalBodySmall.copyWith(),
      ),
      next: Text(
        "Next",
        style: AppTextStyles.textStyleNormalBodySmall.copyWith(),
      ),
      done: Text(
        "Done",
        style: AppTextStyles.textStyleNormalBodySmall.copyWith(),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(30.0, 10.0),
        activeColor: AppColor.blackColor,
        color: AppColor.blackColor,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

final rawPages = [
  const OnBoarding1(),
  const OnBoarding2(),
  const OnBoarding3(),
];
