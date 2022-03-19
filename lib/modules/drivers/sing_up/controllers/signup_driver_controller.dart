import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/sing_up/models/signup_model.dart';
import 'package:let_go_gb/repositories/signup_repository.dart';

class DriverSignUpController extends GetxController {
  var formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final loading = true.obs;
  SignupRepository? _signupRepository;

  File? cnicFrontFile;
  File? cnicBackFile;
  File? drivingLicenceFile;
  String password = "";
  RxBool hidePasswordOne = false.obs;
  RxBool hideConfirmPassword = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _signupRepository = SignupRepository();
  }
  void resetState() {
    firstNameController.clear();
    contactNumberController.clear();
    addressController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailController.clear();
    cnicFrontFile = null;
    cnicBackFile = null;
    drivingLicenceFile = null;
  }

  /// signup model
  SignUpModel  _getUserModel() {

    /// initialize login model with data

    return SignUpModel(
        emailAddress: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        address: addressController.text,
        errorMessage: "Success",
        success: true,
        firstName: firstNameController.text.trim(),
        phone: contactNumberController.text.trim(),
        userRole: "driver",
        id: "",
        cnicFrontImageUrl: cnicFrontFile!.path,
        cnicBackImageUrl: cnicBackFile!.path,
        driverLicenceImageUrl: drivingLicenceFile!.path,
        adminId: ""
    );
  }

  /// save User
  Future<void> saveUser() async {

    loading.value = true;

    bool isSuccess = false;

    final  checkPhoneNoExistBefore = await  _signupRepository!.getUsersWithSamePhone(contactNumberController.text,"0");

    if(!checkPhoneNoExistBefore){

      _signupRepository!.saveUser(_getUserModel())
          .then((value){

        if(value == "Success") {

          isSuccess = true;

          Get.back();

         // resetData(LoadingDriver.driverList);

          Get.showSnackbar(Ui.SuccessSnackBar(message: "User Added successfully"));

        } else {

          isSuccess = false;

          Get.showSnackbar(Ui.ErrorSnackBar(message: value));

        }

      }).whenComplete((){

        if(!isSuccess) loading.value = false;

      });
    }
    else{
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Driver with same phone number already exist"));
      loading.value = false;
    }

  }





}