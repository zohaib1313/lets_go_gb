// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:let_go_gb/common/controller/driver_chat_with_user_controller.dart';
import 'package:let_go_gb/common/pages/chat_screen.dart';
import 'package:let_go_gb/modules/users/controllers/UserMarkBookingCompleteReviewAddController.dart';
import 'package:let_go_gb/modules/users/controllers/home_screen_driver_controller.dart';
import 'package:let_go_gb/modules/users/controllers/login_user_controller.dart';
import 'package:let_go_gb/modules/users/controllers/signup_user_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_blog_detail_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_booking_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_make_booking_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_more_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_rides_controller.dart';
import 'package:let_go_gb/modules/users/controllers/user_vehicle_details_controller.dart';
import 'package:let_go_gb/modules/users/pages/home_screen_user.dart';
import 'package:let_go_gb/modules/users/pages/login_user_screen.dart';
import 'package:let_go_gb/modules/users/pages/user_make_booking_page.dart';
import 'package:let_go_gb/modules/users/pages/user_mark_booking_complete_review_add.dart';
import 'package:let_go_gb/modules/users/pages/user_signup_screen.dart';
import 'package:let_go_gb/modules/users/pages/user_vehicle_details_page.dart';

import '../../common/controller/notification_controller.dart';
import '../../common/pages/notifications_page.dart';
import '../drivers/dashboard/controllers/about_us_controller.dart';
import '../drivers/dashboard/controllers/contact_us_controller.dart';
import '../drivers/dashboard/controllers/privacy_policy_controller.dart';
import '../drivers/dashboard/pages/about_us_page.dart';
import '../drivers/dashboard/pages/contact_us_page.dart';
import '../drivers/dashboard/pages/privacy_policy_page.dart';
import 'controllers/user_view_all_blogs_controller.dart';
import 'pages/user_blog_detail_page.dart';
import 'pages/user_dashboard_page.dart';
import 'pages/user_view_all_blogs_page.dart';

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
    GetPage(
        name: UserMakeBookingPage.id,
        page: () => UserMakeBookingPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<UserMakeBookingController>(
            () => UserMakeBookingController(),
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
        name: UserMarkBookingCompleteReviewAddPage.id,
        page: () => UserMarkBookingCompleteReviewAddPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<UserMarkBookingCompleteReviewAddController>(
            () => UserMarkBookingCompleteReviewAddController(),
          );
        })),
    GetPage(
        name: UserViewAllBlogsPage.id,
        page: () => UserViewAllBlogsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<UserViewAllBlogsController>(
            () => UserViewAllBlogsController(),
          );
        })),
    GetPage(
        name: UserViewBlogDetailsPage.id,
        page: () => UserViewBlogDetailsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<UserBlogDetailController>(
            () => UserBlogDetailController(),
          );
        })),
  ];
}
