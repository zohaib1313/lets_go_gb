import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/app_preferences.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/home_page.dart';
import 'package:let_go_gb/modules/drivers/sing_in/models/login_model.dart';
import 'package:let_go_gb/repositories/login_repository.dart';

class LoginUserController extends GetxController {
  LoginRepository? _loginRepository;

  LoginUserController(){
    _loginRepository = LoginRepository();
  }

  @override
  void onInit() {

    super.onInit();

  }

  final isObscure = true.obs;



  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final loading = false.obs;

  /// Authenticate User with Email and Password
  void login() {

    loading.value = true;

    _loginRepository!.userLogin(emailController.text, passwordController.text)

        .then((UserModel? value){

      _loginResponse(value);

    }).catchError((onError) {

      Get.log("$onError",isError: true);

      Get.showSnackbar(Ui.ErrorSnackBar(message: "$onError"));

    })
        .whenComplete((){

      passwordController.clear();

      loading.value = false;

    });
  }


  void _loginResponse(UserModel? value) {

    if(value!.success!){

      AppPreferences.setUserCredentialsId(value.id!);

      AppPreferences.setUserRole(value.userRole!);

      if (value.userRole == "driver") {

        Get.toNamed(DriverHomePage.id);

      }


    }else{

      Get.log("${value.errorMessage}",isError: true);

      Get.showSnackbar(Ui.ErrorSnackBar(message: "${value.errorMessage}"));

    }

  }
}
