// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:let_go_gb/modules/users/controllers/home_screen_driver_controller.dart';
import 'package:let_go_gb/modules/users/controllers/login_user_controller.dart';
import 'package:let_go_gb/modules/users/controllers/signup_user_controller.dart';
import 'package:let_go_gb/modules/users/pages/home_screen_user.dart';
import 'package:let_go_gb/modules/users/pages/login_user_screen.dart';
import 'package:let_go_gb/modules/users/pages/user_signup_screen.dart';

userAppPages() {
  return [
    GetPage(
        name: UserSignUpScreen.id,
        page: () => UserSignUpScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<UserSignUpController>(
            () => UserSignUpController(),
          );
        })),
    GetPage(
        name: UserLoginScreen.id,
        page: () => UserLoginScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<UserLoginController>(
            () => UserLoginController(),
          );
        })),
    GetPage(
        name: UserHomeScreen.id,
        page: () => UserHomeScreen(),
        binding: BindingsBuilder(() {
          ///putting lazy will dispose controller and throw ticker provider active exception
          Get.put(HomeScreenUserController());

          //  Get.lazyPut<DriverGarageController>(() => DriverGarageController());
        })),
  ];
}
