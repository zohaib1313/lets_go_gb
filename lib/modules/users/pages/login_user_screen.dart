import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/extension/extension.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/utils/app_popups.dart';

import '../../drivers/utils/common_widgets.dart';
import '../../drivers/utils/styles.dart';
import '../../drivers/utils/utils.dart';
import '../controllers/login_user_controller.dart';
import 'user_signup_screen.dart';

class UserLoginScreen extends GetView<UserLoginController> {
  final space = SizedBox(height: 20.h);
  static const id = '/UserLoginScreen';

  UserLoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: GetX<UserLoginController>(
        builder: (controller) => Stack(
          children: [
            Scaffold(
              backgroundColor: AppColor.alphaGrey,
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Container(
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
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome!",
                                  style: AppTextStyles.textStyleBoldTitleLarge
                                      .copyWith(
                                          color: AppColor.primaryBlueColor),
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
                                          controller:
                                              controller.emailController,
                                          leftPadding: 0,
                                          rightPadding: 0,
                                          hintText: "Email",
                                          prefixIcon:
                                              "assets/icons/ic_mail.svg",
                                          focusBorderColor:
                                              AppColor.primaryBlueDarkColor,
                                          textColor: AppColor.blackColor,
                                          hintColor: AppColor.blackColor,
                                          fillColor: AppColor.alphaGrey,
                                          validator: (String? value) =>
                                              value!.toValidEmail()),
                                      space,
                                      Obx(
                                        () => MyTextField(
                                          controller:
                                              controller.passwordController,
                                          leftPadding: 0,
                                          rightPadding: 0,
                                          suffixIconWidet: GestureDetector(
                                              onTap: () {
                                                controller.isObscure.value =
                                                    !controller.isObscure.value;
                                              },
                                              child: Icon(controller
                                                      .isObscure.value
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined)),
                                          hintText: "Password",
                                          prefixIcon:
                                              "assets/icons/ic_lock.svg",
                                          focusBorderColor:
                                              AppColor.primaryBlueDarkColor,
                                          textColor: AppColor.blackColor,
                                          hintColor: AppColor.blackColor,
                                          fillColor: AppColor.alphaGrey,
                                          obsecureText:
                                              controller.isObscure.value,
                                          validator: (String? value) =>
                                              value!.toValidPassword(),
                                        ),
                                      ),
                                      space,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: mySwitch(
                                                message: "Remember me",
                                                isActive: true,
                                                messageColor:
                                                    AppColor.blackColor,
                                                fillColor:
                                                    AppColor.primaryBlueColor,
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
                                                    AppPopUps
                                                        .displayTextInputDialog(
                                                            title:
                                                                "Enter mail where we will send OTP",
                                                            message: "Send Otp",
                                                            hint: "email",
                                                            onSubmit:
                                                                (String text) {
                                                              if (text
                                                                  .isNotEmpty) {}
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
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            controller.login();
                                          }
                                        },
                                      ),
                                      space,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Don't have an account? ",
                                            style: AppTextStyles
                                                .textStyleNormalBodySmall,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(UserSignUpScreen.id);
                                            },
                                            child: Text(
                                              "Sign Up!",
                                              style: AppTextStyles
                                                  .textStyleNormalBodySmall
                                                  .copyWith(
                                                      color: AppColor
                                                          .primaryBlueColor),
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
                    );
                  }),
                ),
              ),
            ),
            if (controller.loading.value) LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
