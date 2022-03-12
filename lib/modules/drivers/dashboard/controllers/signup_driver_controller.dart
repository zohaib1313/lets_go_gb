import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DriverSignUpController extends GetxController {
  var formKey = GlobalKey<FormState>();

  TextEditingController firstNameContoller = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  File? cnicFrontFile;
  File? cnicBackFile;
  File? drivingLicenceFile;

  RxBool hidePasswordOne = false.obs;
  RxBool hideConfirmPassword = false.obs;

  void resetState() {
    firstNameContoller.clear();
    contactNumberController.clear();
    addressController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailController.clear();
    cnicFrontFile = null;
    cnicBackFile = null;
    drivingLicenceFile = null;
  }
}
