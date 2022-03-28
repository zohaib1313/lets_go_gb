import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../utils/styles.dart';
import 'login_driver_screen.dart';
import 'on_boarding_views.dart';

class DriverOnBoardingScreen extends StatefulWidget {
  const DriverOnBoardingScreen({Key? key}) : super(key: key);
  static const id = "/DriverOnBoardingScreen";

  @override
  _DriverOnBoardingScreenState createState() => _DriverOnBoardingScreenState();
}

class _DriverOnBoardingScreenState extends State<DriverOnBoardingScreen> {
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
        Get.toNamed(DriverSignInScreen.id);
      },
      onSkip: () {
        Get.toNamed(DriverSignInScreen.id);
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
