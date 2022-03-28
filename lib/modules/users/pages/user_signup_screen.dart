import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/extension/extension.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';

import '../../drivers/common_widgets/choose_image_widget.dart';
import '../../drivers/utils/common_widgets.dart';
import '../../drivers/utils/styles.dart';
import '../../drivers/utils/utils.dart';
import '../controllers/signup_user_controller.dart';

class UserSignUpScreen extends GetView<UserSignUpController> {
  final space = SizedBox(height: 20.h);
  static const id = '/UserSignUpScreen';

  UserSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: myAppBar(
              title: "User Sign Up",
              onBacKTap: () {
                Get.back();
              }),
          backgroundColor: AppColor.whiteColor,
          body: SafeArea(
            child: GetX<UserSignUpController>(
              builder: (controller) => Stack(
                children: [
                  Column(
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
                                  space,
                                  space,
                                  GestureDetector(
                                    onTap: () {
                                      controller.pickProfileImage();
                                    },
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage: (controller
                                                  .haveProfileImage.value !=
                                              false)
                                          ? Image.file(controller.profileImage!)
                                              .image
                                          : const AssetImage(
                                              'assets/images/place_your_image.png'),
                                    ),
                                  ),
                                  space,
                                  space,
                                  getTextField(
                                    title: "Name",
                                    controller: controller.firstNameController,
                                    validate: (String? value) =>
                                        value!.trim().isEmpty
                                            ? "Name Required"
                                            : null,
                                  ),
                                  space,
                                  getTextField(
                                      title: "Contact Number",
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(13),
                                      ],
                                      controller:
                                          controller.contactNumberController,
                                      validate: (String? value) =>
                                          value!.toValidPhoneNumber()),
                                  space,
                                  getTextField(
                                    title: "Email",
                                    keyboardType: TextInputType.emailAddress,
                                    controller: controller.emailController,
                                    validate: (String? value) =>
                                        value!.toValidEmail(),
                                  ),
                                  space,
                                  getTextField(
                                    title: "Address",
                                    controller: controller.addressController,
                                    validate: (String? value) =>
                                        value!.trim().isEmpty
                                            ? "Address Required"
                                            : null,
                                  ),
                                  space,
                                  MyTextField(
                                    suffixIconWidet: GestureDetector(
                                        onTap: () {
                                          controller.hidePasswordOne.value =
                                              !controller.hidePasswordOne.value;
                                        },
                                        child: Icon(controller
                                                .hidePasswordOne.value
                                            ? Icons.remove_red_eye_rounded
                                            : Icons.visibility_off_outlined)),
                                    fillColor: AppColor.alphaGrey,
                                    keyboardType: TextInputType.visiblePassword,
                                    hintText: "Password",
                                    obsecureText:
                                        controller.hidePasswordOne.value,
                                    controller: controller.passwordController,
                                    validator: (String? value) =>
                                        value!.toValidPassword(),
                                  ),
                                  space,
                                  MyTextField(
                                    suffixIconWidet: GestureDetector(
                                        onTap: () {
                                          controller.hideConfirmPassword.value =
                                              !controller
                                                  .hideConfirmPassword.value;
                                        },
                                        child: Icon(controller
                                                .hideConfirmPassword.value
                                            ? Icons.remove_red_eye_rounded
                                            : Icons.visibility_off_outlined)),
                                    keyboardType: TextInputType.visiblePassword,
                                    fillColor: AppColor.alphaGrey,
                                    hintText: "Confirm Password",
                                    obsecureText:
                                        controller.hideConfirmPassword.value,
                                    controller:
                                        controller.confirmPasswordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Confirm Password Required";
                                      }
                                      if (value !=
                                          controller.passwordController.text) {
                                        return "Password Not Match";
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
                              FocusScope.of(context).unfocus();

                              if (controller.formKey.currentState!.validate()) {
                                if (controller.cnicFrontFile == null) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                      message:
                                          "please choose cnic front copy"));
                                } else if (controller.cnicBackFile == null) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                      message: "please choose cnic back copy"));
                                } else if (controller.drivingLicenceFile ==
                                    null) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                      message:
                                          "please choose your driving licence"));
                                } else if (controller.profileImage == null) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                      message:
                                          "please choose your Profile Image"));
                                } else {
                                  controller.checkIfAccountAlreadyExists(
                                      complete: () {
                                    controller.saveUser();
                                  });
                                }
                              }
                            }),
                      )
                    ],
                  ),
                  if (controller.loading.value) LoadingWidget(),
                ],
              ),
            ),
          ),
        ));
  }

  getTextField(
      {required String title,
      required TextEditingController controller,
      keyboardType = TextInputType.text,
      validate,
      inputFormatters}) {
    return MyTextField(
      fillColor: AppColor.alphaGrey,
      hintText: title,
      labelText: title,
      controller: controller,
      keyboardType: keyboardType,
      validator: validate,
      inputFormatters: inputFormatters,
      //     (string) {
      //   if (string == null || string.isEmpty) {
      //     return 'Enter ${title}';
      //   }
      //   return null;
      // },
    );
  }
}
