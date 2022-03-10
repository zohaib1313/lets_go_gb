import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/screens/home_screen_driver.dart';

import '../../../utils/common_widgets.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';
import '../controllers/signup_driver_controller.dart';

class DriverSignUpScreen extends GetView<DriverSignUpController> {
  final space = SizedBox(height: 20.h);

  DriverSignUpScreen({Key? key}) : super(key: key);

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
                title: "Driver Sign Up",
                onBacKTap: () {
                  Get.back();
                }),
            backgroundColor: AppColor.whiteColor,
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextField(
                              fillColor: AppColor.alphaGrey,
                              hintText: "First Name",
                              labelText: "First Name",
                              controller: controller.firstnameContoller,
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                            space,
                            MyTextField(
                              fillColor: AppColor.alphaGrey,
                              hintText: "Company Mail",
                              labelText: "Company Mail",
                              controller: controller.contactEmailController,
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                            space,
                            MyDropDown(
                              onChange: (value) {},
                              hintText: "Martial Status",
                              labelText: "",
                              labelColor: AppColor.redColor,
                              borderColor: AppColor.alphaGrey,
                              fillColor: AppColor.alphaGrey,
                              suffixIcon: "assets/icons/drop_down_ic.svg",
                              itemFuntion: [
                                DropdownMenuItem(
                                  value: "Married",
                                  child: Text(
                                    "Married",
                                    style: AppTextStyles.textStyleBoldBodySmall,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Single",
                                  child: Text(
                                    "Single",
                                    style: AppTextStyles.textStyleBoldBodySmall,
                                  ),
                                ),
                              ],
                              validator: (string) {
                                return null;
                              },
                            ),
                            space,
                            space,
                            space,
                            space,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(100.r),
                  child: Button(
                    buttonText: "Register",
                    textColor: AppColor.whiteColor,
                    onTap: (){
                      Get.to(HomeScreenDriver());
                    },

                    // onTap: () async {
                    //   if (controller.formKey.currentState!.validate()) {}
                    // },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
