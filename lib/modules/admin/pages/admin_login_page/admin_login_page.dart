import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/controller/admin_login_controller.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/extension/extension.dart';

import '../../../drivers/common_widgets/loading_widget.dart';
import '../../../drivers/utils/common_widgets.dart';
import '../../../drivers/utils/styles.dart';

class AdminLoginPage extends GetView<AdminLoginController> {
  AdminLoginPage({Key? key}) : super(key: key);
  static const id = '/AdminLoginPage';
  final vSpace = SizedBox(height: 20.h);
  final hSpace = SizedBox(width: 50.w);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<AdminLoginController>(
            initState: (state) {},
            builder: (_) {
              controller.loading.value;

              return Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 600,
                      height: context.height * 0.7,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            vSpace,
                            Text(
                              "Login to continue",
                              style: AppTextStyles.textStyleBoldSubTitleLarge,
                            ),
                            vSpace,
                            vSpace,
                            MyTextField(
                                controller: controller.emailController,
                                hintText: "Email",
                                contentPadding: context.height * 0.04,
                                prefixIcon: "assets/icons/ic_mail.svg",
                                focusBorderColor: AppColor.primaryBlueDarkColor,
                                textColor: AppColor.blackColor,
                                hintColor: AppColor.blackColor,
                                fillColor: AppColor.alphaGrey,
                                validator: (String? value) =>
                                    value!.toValidEmail()),
                            vSpace,
                            Obx(
                              () => MyTextField(
                                controller: controller.passwordController,
                                contentPadding: context.height * 0.04,
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
                                focusBorderColor: AppColor.primaryBlueDarkColor,
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
                              padding: context.height * 0.04,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (controller.loading.isTrue) LoadingWidget(),
                ],
              );

              /*ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.mobile) {
                    return Container(color: Colors.red);
                  } else {
                    return Container(color: Colors.blue);
                  }
                },
              );*/
            }),
      ),
    );
  }
}
