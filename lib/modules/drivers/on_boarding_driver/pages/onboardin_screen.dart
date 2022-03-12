import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../home/pages/login_driver_screen.dart';
import '../../utils/styles.dart';
import 'on_boarding_views.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const id = "on_boarding";

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      rawPages: rawPages,

      // freeze: true,
      controlsMargin: const EdgeInsets.all(10),
      onDone: () {
        Get.off(() => LoginDriverScreen());
      },
      onSkip: () {
        Get.off(() => LoginDriverScreen());
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
