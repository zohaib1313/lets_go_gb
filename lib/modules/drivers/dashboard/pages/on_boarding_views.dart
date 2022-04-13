import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../utils/styles.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/animations/travel_car_anim.json',
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 100.w,
                      right: 100.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Greetings...!",
                            style: AppTextStyles.textStyleBoldTitleLarge
                                .copyWith(fontSize: 30)),
                        space,
                        Text(
                          "Welcome to Explore Gilgit Baltistan. Your trip to Skardu at one click",
                          style: AppTextStyles.textStyleBoldSubTitleLarge
                              .copyWith(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  _OnBoarding2State createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Lottie.asset(
                'assets/animations/mountains.json',
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 100.w,
                  right: 100.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    space,
                    Text("Want to go for a tour..?",
                        style: AppTextStyles.textStyleBoldTitleLarge
                            .copyWith(fontSize: 30)),
                    space,
                    Text(
                      "We offer our distinguished guests a safe and memorable tour.",
                      style:
                          AppTextStyles.textStyleBoldSubTitleLarge.copyWith(),
                    ),
                    space,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  _OnBoarding3State createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  space,
                  Lottie.asset(
                    'assets/animations/car_rush.json',
                  ),
                  space,
                  Padding(
                    padding: EdgeInsets.only(
                      left: 100.w,
                      right: 100.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("We are here..!",
                            style: AppTextStyles.textStyleBoldTitleLarge
                                .copyWith(fontSize: 30)),
                        space,
                        Text(
                          "Select the car of your choice and we will take wherever you want in GB.",
                          style: AppTextStyles.textStyleBoldSubTitleLarge
                              .copyWith(),
                        ),
                      ],
                    ),
                  ),
                  space,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
