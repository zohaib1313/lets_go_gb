import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_home_page.dart';
import 'package:let_go_gb/modules/drivers/sing_up/models/signup_model.dart';
import 'package:let_go_gb/modules/drivers/utils/app_user_roles.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/repositories/login_repository.dart';

class LoginDriverController extends GetxController {
  LoginRepository? _loginRepository;

  LoginDriverController() {
    _loginRepository = LoginRepository();
  }

  final isObscure = true.obs;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final loading = false.obs;

  /// Authenticate User with Email and Password
  void login() {
    loading.value = true;

    _loginRepository!
        .userLogin(emailController.text.trim(), passwordController.text.trim())
        .then((DriverUserModel? value) {
      _loginResponse(value);
    }).catchError((onError) {
      Get.log("$onError", isError: true);

      Get.showSnackbar(Ui.ErrorSnackBar(message: "$onError"));
    }).whenComplete(() {
      passwordController.clear();
      loading.value = false;
    });
  }

  void _loginResponse(DriverUserModel? value) {
    if (value?.success ?? false) {
      if (value!.userRole == AppUserRoles.driver) {
        UserDefaults.saveDriverSession(value);
        Get.offAndToNamed(DriverHomePage.id);
      }
    } else {
      Get.log("${value?.errorMessage}", isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "${value?.errorMessage}"));
    }
  }
}
