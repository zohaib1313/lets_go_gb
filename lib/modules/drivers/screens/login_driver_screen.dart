import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/controllers/login_driver_controller.dart';

import '../../../utils/app_popups.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';
import 'driver_signup_screen.dart';

class LoginDriverScreen extends GetView<LoginDriverController> {
  final space = SizedBox(height: 20.h);

  LoginDriverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              AppColor.whiteColor //or the color you prefer
          ),
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
            appBar: myAppBar(
                title: "Sign in",
                onBacKTap: () {
                  Navigator.of(context).pop();
                }),
            backgroundColor: AppColor.alphaGrey,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(
                  left: 100.w,
                  right: 100.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgViewer(
                        width: double.infinity,
                        height: 500.h,
                        svgPath: "assets/icons/sign_in_ic.svg"),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome!",
                            style: AppTextStyles.textStyleBoldTitleLarge
                                .copyWith(color: AppColor.primaryBlueColor),
                          ),
                          Text(
                            "Sign in to continue",
                            style: AppTextStyles.textStyleNormalLargeTitle
                                .copyWith(color: AppColor.blackColor),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 20.r,
                                bottom: 20.r,
                                left: 80.r,
                                right: 80.r),
                            margin: EdgeInsets.only(
                              top: 100.r,
                              bottom: 100.r,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Column(
                              children: [
                                space,
                                MyTextField(
                                  leftPadding: 0,
                                  rightPadding: 0,
                                  hintText: "Email",
                                  prefixIcon: "assets/icons/ic_mail.svg",
                                  focusBorderColor:
                                      AppColor.primaryBlueDarkColor,
                                  textColor: AppColor.blackColor,
                                  hintColor: AppColor.blackColor,
                                  fillColor: AppColor.alphaGrey,
                                  validator: (string) {
                                    if (string == null || string.isEmpty) {
                                      return 'Enter Email';
                                    }
                                    return null;
                                  },
                                ),
                                space,
                                MyTextField(
                                  leftPadding: 0,
                                  rightPadding: 0,
                                  suffixIconWidet: GestureDetector(
                                      onTap: () {},
                                      child: Icon(true
                                          ? Icons.remove_red_eye_rounded
                                          : Icons.visibility_off_outlined)),
                                  hintText: "Password",
                                  obsecureText: true,
                                  prefixIcon: "assets/icons/ic_lock.svg",
                                  focusBorderColor:
                                      AppColor.primaryBlueDarkColor,
                                  textColor: AppColor.blackColor,
                                  hintColor: AppColor.blackColor,
                                  fillColor: AppColor.alphaGrey,
                                  validator: (string) {
                                    if (string == null || string.isEmpty) {
                                      return 'Enter Password';
                                    }
                                    return null;
                                  },
                                ),
                                space,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: mySwitch(
                                          message: "Remember me",
                                          isActive: true,
                                          messageColor: AppColor.blackColor,
                                          fillColor: AppColor.primaryBlueColor,
                                          checkColor: AppColor.whiteColor,
                                          onTap: () {}),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              AppPopUps.displayTextInputDialog(
                                                  title:
                                                      "Enter mail where we will send OTP",
                                                  message: "Send Otp",
                                                  hint: "email",
                                                  onSubmit: (String text) {
                                                    if (text.isNotEmpty) {}
                                                  });
                                            },
                                            child: Text(
                                              "Forgot Password ?",
                                              style: AppTextStyles
                                                  .textStyleNormalBodySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                space,
                                Button(
                                  buttonText: "Sign in",
                                  textColor: AppColor.whiteColor,
                                  color: AppColor.primaryBlueDarkColor,
                                  onTap: () {
                                    Get.to(() => DriverSignUpScreen());
                                  },
                                ),
                                space,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have not an account? ",
                                      style: AppTextStyles
                                          .textStyleNormalBodySmall,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "Sign Up!",
                                        style: AppTextStyles
                                            .textStyleNormalBodySmall
                                            .copyWith(
                                                color:
                                                    AppColor.primaryBlueColor),
                                      ),
                                    ),
                                  ],
                                ),
                                space,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
