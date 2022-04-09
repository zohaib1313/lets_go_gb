// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:let_go_gb/common/controller/chat_home_controller.dart';
import 'package:let_go_gb/common/controller/driver_chat_with_user_controller.dart';
import 'package:let_go_gb/common/pages/chat_screen.dart';
import 'package:let_go_gb/common/pages/notifications_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/about_us_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/add_new_vehicle_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/contact_us_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_booking_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_dashboard_home_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_garage_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/login_driver_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/privacy_policy_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/signup_driver_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/about_us_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/contact_us_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_add_new_vehicle_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_dashboard_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_home_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_signup_screen.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_view_all_bookings_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/login_driver_screen.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/privacy_policy_page.dart';

import '../../common/controller/notification_controller.dart';
import 'dashboard/controllers/DriverBookingDetailController.dart';
import 'dashboard/controllers/driver_more_controller.dart';
import 'dashboard/pages/driver_booking_detail_page.dart';

driverAppPages() {
  return [
    ///driver////////////////////////////////////////////////////////
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
          Get.put(ChatHomeController());
          Get.put(DriverMoreController());

          //  Get.lazyPut<DriverGarageController>(() => DriverGarageController());
        })),
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
        name: NotificationsPage.id,
        page: () => NotificationsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<NotificationsController>(
            () => NotificationsController(),
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
