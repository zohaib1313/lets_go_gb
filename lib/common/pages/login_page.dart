import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/controller/login_controller.dart';
import 'package:let_go_gb/common/pages/choose_signup_page.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/extension/extension.dart';

import '../../modules/drivers/common_widgets/loading_widget.dart';
import '../../modules/drivers/utils/common_widgets.dart';
import '../../modules/drivers/utils/styles.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);
  static const id = '/LoginPage';
  final vSpace = SizedBox(height: 20.h);
  final hSpace = SizedBox(width: 50.w);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<LoginController>(
            initState: (state) {},
            builder: (_) {
              controller.loading.value;

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: 400,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                vSpace,
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 200,
                                  width: 200,
                                ),
                                Text(
                                  "Login to continue",
                                  style:
                                      AppTextStyles.textStyleBoldSubTitleLarge,
                                ),
                                vSpace,
                                vSpace,
                                MyTextField(
                                    leftPadding: 0,
                                    rightPadding: 0,
                                    controller: controller.emailController,
                                    hintText: "Email",
                                    contentPadding:
                                        16 /* context.height * 0.04*/,
                                    prefixIcon: "assets/icons/ic_mail.svg",
                                    focusBorderColor:
                                        AppColor.primaryBlueDarkColor,
                                    textColor: AppColor.blackColor,
                                    hintColor: AppColor.blackColor,
                                    fillColor: AppColor.alphaGrey,
                                    validator: (String? value) =>
                                        value!.toValidEmail()),
                                vSpace,
                                Obx(
                                  () => MyTextField(
                                    leftPadding: 0,
                                    rightPadding: 0,
                                    controller: controller.passwordController,
                                    contentPadding:
                                        16 /* context.height * 0.04*/,
                                    suffixIconWidet: GestureDetector(
                                        onTap: () {
                                          controller.isObscure.value =
                                              !controller.isObscure.value;
                                        },
                                        child: Icon(controller.isObscure.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined)),
                                    hintText: "Password",
                                    prefixIcon: "assets/icons/ic_lock.svg",
                                    focusBorderColor:
                                        AppColor.primaryBlueDarkColor,
                                    textColor: AppColor.blackColor,
                                    hintColor: AppColor.blackColor,
                                    fillColor: AppColor.alphaGrey,
                                    obsecureText: controller.isObscure.value,
                                    validator: (String? value) =>
                                        value!.toValidPassword(),
                                  ),
                                ),
                                vSpace,
                                vSpace,
                                Button(
                                  buttonText: "Log in",
                                  leftPadding: 0,
                                  rightPading: 0,
                                  padding: 16 /*context.height * 0.04*/,
                                  textColor: AppColor.whiteColor,
                                  color: AppColor.primaryBlueDarkColor,
                                  onTap: () {
                                    FocusScope.of(context).unfocus();

                                    //     controller.createAdminUser();
                                    if (_formKey.currentState!.validate()) {
                                      controller.login();
                                    }
                                  },
                                ),
                                vSpace,
                                Text(
                                  "Don't have an account?",
                                  style:
                                      AppTextStyles.textStyleNormalBodyMedium,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.off(const ChooseSignUpPage());
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: AppTextStyles.textStyleBoldBodyMedium
                                        .copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            color: AppColor.primaryBlueColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (controller.loading.isTrue) LoadingWidget(),
                ],
              );
            }),
      ),
    );
  }
}
