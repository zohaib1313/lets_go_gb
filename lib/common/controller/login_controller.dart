import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/models/admin_model.dart';
import 'package:let_go_gb/modules/admin/pages/home_page/admin_home_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_home_page.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/users/pages/home_screen_user.dart';

import '../../modules/drivers/common_widgets/ui.dart';
import '../../modules/drivers/utils/app_user_roles.dart';
import '../../modules/drivers/utils/user_defaults.dart';
import '../../repositories/login_repository.dart';

class LoginController extends GetxController {
  final loading = false.obs;
  LoginRepository? _loginRepository;

  @override
  void onInit() {
    _loginRepository = LoginRepository();
    super.onInit();
  }

  final isObscure = true.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    loading.value = true;

    _loginRepository!
        .adminLogin(emailController.text.trim(), passwordController.text.trim())
        .then((dynamic value) {
      _loginResponse(value);
    }).catchError((onError) {
      Get.log("$onError", isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "$onError"));
    }).whenComplete(() {
      passwordController.clear();
      loading.value = false;
    });
  }

  void _loginResponse(dynamic value) {
    if (value?.success ?? false) {
      if (value!.userRole == AppUserRoles.admin) {
        UserDefaults.saveAdminSession(value);

        Get.offAndToNamed(AdminHomePage.id);
      } else if (value!.userRole == AppUserRoles.user) {
        UserDefaults.saveUserSession(value);
        Get.offAndToNamed(UserHomeScreen.id);
      } else if (value!.userRole == AppUserRoles.driver) {
        UserDefaults.saveDriverSession(value);
        Get.offAndToNamed(DriverHomePage.id);
      }
    } else {
      Get.log("${value?.errorMessage}", isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "${value?.errorMessage}"));
    }
  }

  void createAdminUser() {
    AdminModel adminModel = AdminModel(
        id: "E3DiAqEFjtMg2e8SvJ0LScPROuR2",
        address: "Lodhran",
        isActive: true,
        deviceTokenId: "",
        emailAddress: "admin@gmail.com",
        errorMessage: "Success",
        firstName: "Admin",
        phone: "0900",
        profileImage: "",
        success: true,
        userRole: AppUserRoles.admin);

    FirebaseFirestore.instance
        .collection(FirebasePathNodes.users)
        .doc("E3DiAqEFjtMg2e8SvJ0LScPROuR2")
        .set(adminModel.toMap());
  }
}
