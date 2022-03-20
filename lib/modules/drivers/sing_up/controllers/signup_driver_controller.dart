import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/dropdown.dart';
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
  final loading = false.obs;

  final statusDropDown = Dropdown().obs;
  List<Dropdown> statusDropDownList = [];
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
    _signupRepository = SignupRepository();
    loadStatusDropdown();
    super.onInit();
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
    statusDropDown.value = statusDropDownList.first;
  }

  /// map of status list
  Map<String, int> _getStatusMap() {
    return {
      "Active" : 1,
      "InActive" : 2,
    };
  }

  /// load paid status list
  Future<void> loadStatusDropdown() async {

    List<Dropdown> _list = [];

    _getStatusMap().forEach((key, value) {

      _list.add(Dropdown(name: key, id: value));

    });


    if(_list.isNotEmpty) {

      statusDropDownList = _list;

      statusDropDown.value = _list.first;

    }
  }




/// signup model
  SignUpModel _getUserModel() {
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
        isActive: false,
        cnicFrontImageUrl: cnicFrontFile?.path ?? '',
        cnicBackImageUrl: cnicBackFile?.path ?? "",
        driverLicenceImageUrl: drivingLicenceFile?.path ?? '',
        adminId: "");
  }

  /// save User
  Future<void> saveUser() async {
    loading.value = true;

    bool isSuccess = false;

    _signupRepository!.saveUser(_getUserModel()).then((value) {
      if (value == "Success") {
        isSuccess = true;

        Get.back();

        Get.showSnackbar(Ui.SuccessSnackBar(message: "User Added successfully"));
      } else {
        isSuccess = false;

        Get.showSnackbar(Ui.ErrorSnackBar(message: value));
      }
    }).whenComplete(() {
      if (!isSuccess) loading.value = false;
    });

    }
}
