import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_dashboard_page.dart';

import '../../common_widgets/choose_image_widget.dart';
import '../../utils/common_widgets.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';
import '../controllers/signup_driver_controller.dart';

class DriverSignUpScreen extends GetView<DriverSignUpController> {
  final space = SizedBox(height: 20.h);
  static const id = '/DriverSignUpScreen';

  DriverSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getTextField(
                              title: "Name",
                              controller: controller.firstNameContoller),
                          space,
                          getTextField(
                              title: "Contact Number",
                              controller: controller.contactNumberController),
                          space,
                          getTextField(
                              title: "Email",
                              controller: controller.emailController),
                          space,
                          getTextField(
                              title: "Address",
                              controller: controller.addressController),
                          space,
                          space,
                          MyTextField(
                            suffixIconWidet: GestureDetector(
                                onTap: () {
                                  controller.hidePasswordOne.value =
                                      !controller.hidePasswordOne.value;
                                },
                                child: Icon(controller.hidePasswordOne.value
                                    ? Icons.remove_red_eye_rounded
                                    : Icons.visibility_off_outlined)),
                            fillColor: AppColor.alphaGrey,
                            hintText: "Password",
                            obsecureText: controller.hidePasswordOne.value,
                            controller: controller.passwordController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Password';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            suffixIconWidet: GestureDetector(
                                onTap: () {
                                  controller.hideConfirmPassword.value =
                                      !controller.hideConfirmPassword.value;
                                },
                                child: Icon(controller.hidePasswordOne.value
                                    ? Icons.remove_red_eye_rounded
                                    : Icons.visibility_off_outlined)),
                            fillColor: AppColor.alphaGrey,
                            hintText: "Confirm Password",
                            obsecureText: controller.hideConfirmPassword.value,
                            controller: controller.confirmPasswordController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Confirm Password';
                              }
                              return null;
                            },
                          ),
                          space,
                          space,
                          space,
                          ChooseImageWidget(
                            chooseTitle: 'CNIC FRONT',
                            onImageChoosed: (File? file) {
                              controller.cnicFrontFile = file;
                            },
                          ),
                          space,
                          ChooseImageWidget(
                            chooseTitle: 'CNIC Back',
                            onImageChoosed: (File? file) {
                              controller.cnicBackFile = file;
                            },
                          ),
                          space,
                          ChooseImageWidget(
                            chooseTitle: 'Driving License',
                            onImageChoosed: (File? file) {
                              controller.drivingLicenceFile = file;
                            },
                          ),
                          space,
                          space,
                          space,
                          space,
                          /* MyDropDown(
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
                          ),*/
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
                  onTap: () {
                    Get.to(const DriverDashBoard());
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
    );
  }

  getTextField(
      {required String title, required TextEditingController controller}) {
    return MyTextField(
      fillColor: AppColor.alphaGrey,
      hintText: title,
      labelText: title,
      controller: controller,
      validator: (string) {
        if (string == null || string.isEmpty) {
          return 'Enter ${title}';
        }
        return null;
      },
    );
  }
}
