// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/about_us_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/add_new_vehicle_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/contact_us_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_booking_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_chat_home_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_chat_with_user_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_dashboard_home_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_garage_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_notifications_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/login_driver_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/privacy_policy_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/signup_driver_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/about_us_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/contact_us_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_add_new_vehicle_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_chat_screen.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_dashboard_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_home_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_notifications_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_signup_screen.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_view_all_bookings_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/login_driver_screen.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/privacy_policy_page.dart';

import 'dashboard/controllers/DriverBookingDetailController.dart';
import 'dashboard/controllers/driver_more_controller.dart';
import 'dashboard/pages/driver_booking_detail_page.dart';

appPages() {
  return [
    GetPage(
        name: DriverSignUpScreen.id,
        page: () => DriverSignUpScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<DriverSignUpController>(
            () => DriverSignUpController(),
          );
        })),
    GetPage(
        name: DriverHomePage.id,
        page: () => const DriverDashBoard(),
        binding: BindingsBuilder(() {
          ///putting lazy will dispose controller and throw ticker provider active exception
          Get.put(DriverDashBoardHomeController());
          Get.put(DriverGarageController());
          Get.put(DriverChatHomeController());
          Get.put(DriverMoreController());

          //  Get.lazyPut<DriverGarageController>(() => DriverGarageController());
        })),

    ///login binding
    GetPage(
        name: DriverSignInScreen.id,
        page: () => DriverSignInScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<LoginDriverController>(
            () => LoginDriverController(),
          );
        })),

    GetPage(
        name: DriverAddNewVehiclePage.id,
        page: () => DriverAddNewVehiclePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AddNewVehicleController>(
            () => AddNewVehicleController(),
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

    GetPage(
        name: DriverBookingDetailsPage.id,
        page: () => DriverBookingDetailsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<DriverBookingDetailController>(
            () => DriverBookingDetailController(),
          );
        })),

    GetPage(
        name: DriverViewAllBookingsPage.id,
        page: () => DriverViewAllBookingsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<DriverBookingController>(
            () => DriverBookingController(),
          );
        })),

    GetPage(
        name: DriverNotificationsPage.id,
        page: () => DriverNotificationsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<DriverNotificationsController>(
            () => DriverNotificationsController(),
          );
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
  ];
}
