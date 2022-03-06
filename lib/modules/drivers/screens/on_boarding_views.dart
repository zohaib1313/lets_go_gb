import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/styles.dart';

class OnBoardingOurCompanyInfo extends StatefulWidget {
  const OnBoardingOurCompanyInfo({Key? key}) : super(key: key);

  @override
  _OnBoardingOurCompanyInfoState createState() =>
      _OnBoardingOurCompanyInfoState();
}

class _OnBoardingOurCompanyInfoState extends State<OnBoardingOurCompanyInfo> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
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
                        Text("Plan a Trip",
                            style: AppTextStyles.textStyleBoldTitleLarge
                                .copyWith(fontSize: 30)),
                        space,
                        Text(
                          "You can plan a trip,or we can help you by suggesting you the set of good time and ride",
                          style: AppTextStyles.textStyleNormalBodyMedium
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

///////////////For Clients//////////

class OnBoardingForClients extends StatefulWidget {
  const OnBoardingForClients({Key? key}) : super(key: key);

  @override
  _OnBoardingForClientsState createState() => _OnBoardingForClientsState();
}

class _OnBoardingForClientsState extends State<OnBoardingForClients> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
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
                    Text("Title 2",
                        style: AppTextStyles.textStyleBoldTitleLarge
                            .copyWith(fontSize: 30)),
                    space,
                    Text(
                      "utpain was born and I will give you a co are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage ",
                      style: AppTextStyles.textStyleNormalBodyMedium.copyWith(),
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
///////////////For Applicants//////////

class OnBoardingForApplicant extends StatefulWidget {
  const OnBoardingForApplicant({Key? key}) : super(key: key);

  @override
  _OnBoardingForApplicantState createState() => _OnBoardingForApplicantState();
}

class _OnBoardingForApplicantState extends State<OnBoardingForApplicant> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
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
                        Text("Title 3",
                            style: AppTextStyles.textStyleBoldTitleLarge
                                .copyWith(fontSize: 30)),
                        space,
                        Text(
                          "utpain was born and I will give you a co are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage ",
                          style: AppTextStyles.textStyleNormalBodyMedium
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
