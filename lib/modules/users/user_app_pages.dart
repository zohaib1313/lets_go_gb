// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_chat_with_user_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_chat_screen.dart';
import 'package:let_go_gb/modules/users/controllers/home_screen_driver_controller.dart';
import 'package:let_go_gb/modules/users/controllers/login_user_controller.dart';
import 'package:let_go_gb/modules/users/controllers/signup_user_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_booking_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_more_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_rides_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_vehicle_details_controller.dart';
import 'package:let_go_gb/modules/users/pages/home_screen_user.dart';
import 'package:let_go_gb/modules/users/pages/login_user_screen.dart';
import 'package:let_go_gb/modules/users/pages/user_signup_screen.dart';
import 'package:let_go_gb/modules/users/pages/user_vehicle_details_page.dart';

import '../drivers/dashboard/controllers/about_us_controller.dart';
import '../drivers/dashboard/controllers/contact_us_controller.dart';
import '../drivers/dashboard/controllers/privacy_policy_controller.dart';
import '../drivers/dashboard/pages/about_us_page.dart';
import '../drivers/dashboard/pages/contact_us_page.dart';
import '../drivers/dashboard/pages/privacy_policy_page.dart';
import 'pages/user_dashboard_page.dart';

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
        page: () => UserDashboardPage(),
        binding: BindingsBuilder(() {
          ///putting lazy will dispose controller and throw ticker provider active exception
          Get.put(HomeScreenUserController());
          Get.put(UserBookingController());
          Get.put(UserRideController());
          Get.put(UserMoreController());

          //  Get.lazyPut<DriverGarageController>(() => DriverGarageController());
        })),
    GetPage(
        name: PrivacyPolicyPage.id,
        page: () => PrivacyPolicyPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<PrivacyPolicyController>(
            () => PrivacyPolicyController(),
          );
        })),
    GetPage(
        name: AboutUsPage.id,
        page: () => AboutUsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AboutUsController>(
            () => AboutUsController(),
          );
        })),
    GetPage(
        name: ContactUsPage.id,
        page: () => ContactUsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ContactUsController>(
            () => ContactUsController(),
          );
        })),
    GetPage(
        name: UserVehicleDetailPage.id,
        page: () => UserVehicleDetailPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<UserVehicleDetailsController>(
            () => UserVehicleDetailsController(),
          );
        })),
    GetPage(
        name: ChatScreen.id,
        page: () => ChatScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<DriverChatWithUserController>(
            () => DriverChatWithUserController(),
          );
        })),
  ];
}
