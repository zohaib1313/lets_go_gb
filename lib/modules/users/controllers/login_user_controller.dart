import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/utils/app_user_roles.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';
import 'package:let_go_gb/modules/users/pages/home_screen_user.dart';
import 'package:let_go_gb/repositories/login_repository.dart';

class UserLoginController extends GetxController {
  LoginRepository? _loginRepository;

  UserLoginController() {
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
        .userUserLogin(
            emailController.text.trim(), passwordController.text.trim())
        .then((UserModel? value) {
      _loginResponse(value);
    }).catchError((onError) {
      Get.log("$onError", isError: true);

      Get.showSnackbar(Ui.ErrorSnackBar(message: "$onError"));
    }).whenComplete(() {
      passwordController.clear();
      loading.value = false;
    });
  }

  void _loginResponse(UserModel? value) {
    if (value?.success ?? false) {
      if (value!.userRole == AppUserRoles.user) {
        UserDefaults.saveUserSession(value);
        Get.offAndToNamed(UserHomeScreen.id);
      }
    } else {
      Get.log("${value?.errorMessage}", isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "${value?.errorMessage}"));
    }
  }
}
