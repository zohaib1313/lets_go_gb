import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:let_go_gb/common/pages/login_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_signup_screen.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

import '../../modules/users/pages/user_signup_screen.dart';

class ChooseSignUpPage extends StatelessWidget {
  ChooseSignUpPage({Key? key}) : super(key: key);
  static const id = "/ChooseSignUpPage";
  var vSpace = const SizedBox(height: 20);
  var hSpace = const SizedBox(width: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColor.primaryBlueColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Hero(
                  tag: "logoSigUp",
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 300,
                    width: 300,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
            ),
            vSpace,
            Text(
              "Sign up for account",
              style: AppTextStyles.textStyleBoldSubTitleLarge,
            ),
            vSpace,
            Button(
              onTap: () {
                Get.toNamed(DriverSignUpScreen.id);
              },
              buttonText: "Sign up as driver",
              textColor: AppColor.whiteColor,
              postFixIcon: const Icon(
                Icons.arrow_forward,
                color: AppColor.whiteColor,
              ),
            ),
            vSpace,
            Button(
              onTap: () {
                Get.toNamed(UserSignUpScreen.id);
              },
              buttonText: "Sign up as user",
              textColor: AppColor.whiteColor,
              postFixIcon: const Icon(
                Icons.arrow_forward,
                color: AppColor.whiteColor,
              ),
            ),
            vSpace,
            Text(
              "Already have an account?",
              style: AppTextStyles.textStyleNormalBodyMedium,
            ),
            InkWell(
              onTap: () {
                Get.offAndToNamed(LoginPage.id);
              },
              child: Text(
                "Login",
                style: AppTextStyles.textStyleBoldBodyMedium.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColor.primaryBlueColor),
              ),
            ),
            vSpace,
          ],
        ),
      ),
    );
  }
}
