import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/extension/extension.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';

import '../../common_widgets/choose_image_widget.dart';
import '../../utils/common_widgets.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';
import '../controllers/signup_driver_controller.dart';
import '../models/driver_user_model.dart';

class DriverSignUpScreen extends GetView<DriverSignUpController> {
  final space = SizedBox(height: 20.h);
  static const id = '/DriverSignUpScreen';

  DriverSignUpScreen({Key? key}) : super(key: key);

  DriverUserModel? driverUserModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: myAppBar(
            title: driverUserModel != null
                ? "Update Your Profile"
                : "Driver Sign Up",
            onBacKTap: () {
              Get.back();
            },
          ),
          backgroundColor: AppColor.whiteColor,
          body: SafeArea(
            child: GetX<DriverSignUpController>(
              initState: (state) {
                if (driverUserModel != null) {
                  controller.setValuesWithUpdated(driverUserModel!);
                }
              },
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
                                    onTap: () async {
                                      await controller.pickProfileImage();
                                    },
                                    child: getImage(),
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
                                  if (driverUserModel == null)
                                    Column(
                                      children: [
                                        space,
                                        getTextField(
                                          title: "Email",
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller:
                                              controller.emailController,
                                          validate: (String? value) =>
                                              value!.toValidEmail(),
                                        ),
                                      ],
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
                                  if (driverUserModel == null)
                                    Column(
                                      children: [
                                        space,
                                        MyTextField(
                                          suffixIconWidet: GestureDetector(
                                              onTap: () {
                                                controller
                                                        .hidePasswordOne.value =
                                                    !controller
                                                        .hidePasswordOne.value;
                                              },
                                              child: Icon(controller
                                                      .hidePasswordOne.value
                                                  ? Icons.remove_red_eye_rounded
                                                  : Icons
                                                      .visibility_off_outlined)),
                                          fillColor: AppColor.alphaGrey,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          hintText: "Password",
                                          obsecureText:
                                              controller.hidePasswordOne.value,
                                          controller:
                                              controller.passwordController,
                                          validator: (String? value) =>
                                              value!.toValidPassword(),
                                        ),
                                        space,
                                        MyTextField(
                                          suffixIconWidet: GestureDetector(
                                              onTap: () {
                                                controller.hideConfirmPassword
                                                        .value =
                                                    !controller
                                                        .hideConfirmPassword
                                                        .value;
                                              },
                                              child: Icon(controller
                                                      .hideConfirmPassword.value
                                                  ? Icons.remove_red_eye_rounded
                                                  : Icons
                                                      .visibility_off_outlined)),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          fillColor: AppColor.alphaGrey,
                                          hintText: "Confirm Password",
                                          obsecureText: controller
                                              .hideConfirmPassword.value,
                                          controller: controller
                                              .confirmPasswordController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Confirm Password Required";
                                            }
                                            if (value !=
                                                controller
                                                    .passwordController.text) {
                                              return "Password Not Match";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  space,
                                  space,
                                  space,
                                  ChooseImageWidget(
                                    chooseTitle: 'CNIC FRONT',
                                    networkUrl:
                                        driverUserModel?.cnicFrontImageUrl,
                                    onImageChoosed: (File? file) {
                                      controller.cnicFrontFile = file;
                                    },
                                  ),
                                  space,
                                  ChooseImageWidget(
                                    chooseTitle: 'CNIC Back',
                                    networkUrl:
                                        driverUserModel?.cnicBackImageUrl,
                                    onImageChoosed: (File? file) {
                                      controller.cnicBackFile = file;
                                    },
                                  ),
                                  space,
                                  ChooseImageWidget(
                                    chooseTitle: 'Driving License',
                                    networkUrl:
                                        driverUserModel?.driverLicenceImageUrl,
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
                            buttonText:
                                driverUserModel == null ? "Register" : "Update",
                            textColor: AppColor.whiteColor,
                            onTap: () {
                              FocusScope.of(context).unfocus();

                              if (controller.formKey.currentState!.validate()) {
                                if (controller.cnicFrontFile == null &&
                                    driverUserModel?.cnicFrontImageUrl ==
                                        null) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                      message:
                                          "please choose cnic front copy"));
                                } else if (controller.cnicBackFile == null &&
                                    driverUserModel?.cnicBackImageUrl == null) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                      message: "please choose cnic back copy"));
                                } else if (controller.drivingLicenceFile ==
                                        null &&
                                    driverUserModel?.driverLicenceImageUrl ==
                                        null) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                      message:
                                          "please choose your driving licence"));
                                } else if (controller.profileImage == null &&
                                    driverUserModel?.profileImage == null) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                      message:
                                          "please choose your Profile Image"));
                                } else {
                                  if (driverUserModel != null) {
                                    controller.setUser(driverUserModel);
                                  } else {
                                    controller.checkIfAccountAlreadyExists(
                                        complete: () {
                                      controller.setUser(driverUserModel);
                                    });
                                  }
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

  Widget getImage() {
    if (controller.haveProfileImage.value) {
      return CircleAvatar(
          radius: 80,
          backgroundImage: Image.file(controller.profileImage!).image);
    } else if (driverUserModel?.profileImage != null) {
      return NetworkCircularImage(
        url: driverUserModel!.profileImage!,
        radius: 80,
      );
    } else {
      return const CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('assets/images/place_your_image.png'));
    }
  }
}
