import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:let_go_gb/common/controller/chat_home_controller.dart';
import 'package:let_go_gb/common/controller/driver_chat_with_user_controller.dart';
import 'package:let_go_gb/common/controller/login_controller.dart';
import 'package:let_go_gb/common/controller/notification_controller.dart';
import 'package:let_go_gb/common/pages/chat_screen.dart';
import 'package:let_go_gb/common/pages/login_page.dart';
import 'package:let_go_gb/modules/admin/controller/admin_dashboard_home_controller.dart';
import 'package:let_go_gb/modules/admin/controller/admin_home_controller.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_bookings_controller.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_drivers_controller.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_users_controller.dart';
import 'package:let_go_gb/modules/admin/controller/promoted_vehicles_controller.dart';
import 'package:let_go_gb/modules/admin/pages/blogs_page/admin_add_new_blog_page.dart';
import 'package:let_go_gb/modules/admin/pages/home_page/admin_home_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/about_us_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_booking_detail_page.dart';
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
import 'modules/admin/controller/admin_add_new_blog_controller.dart';
import 'modules/admin/controller/admin_view_all_blogs_controller.dart';
import 'modules/drivers/dashboard/controllers/DriverBookingDetailController.dart';
import 'modules/drivers/dashboard/controllers/add_new_vehicle_controller.dart';
import 'modules/drivers/dashboard/controllers/contact_us_controller.dart';
import 'modules/drivers/dashboard/controllers/driver_booking_controller.dart';
import 'modules/drivers/dashboard/controllers/driver_dashboard_home_controller.dart';
import 'modules/drivers/dashboard/controllers/driver_garage_controller.dart';
import 'modules/drivers/dashboard/controllers/driver_more_controller.dart';
import 'modules/drivers/dashboard/controllers/login_driver_controller.dart';
import 'modules/drivers/dashboard/controllers/privacy_policy_controller.dart';
import 'modules/drivers/dashboard/controllers/signup_driver_controller.dart';
import 'modules/drivers/dashboard/pages/about_us_page.dart';
import 'modules/drivers/dashboard/pages/contact_us_page.dart';
import 'modules/drivers/dashboard/pages/driver_add_new_vehicle_page.dart';
import 'modules/drivers/dashboard/pages/driver_dashboard_page.dart';
import 'modules/drivers/dashboard/pages/driver_home_page.dart';
import 'modules/drivers/dashboard/pages/driver_signup_screen.dart';
import 'modules/drivers/dashboard/pages/driver_view_all_bookings_page.dart';
import 'modules/drivers/dashboard/pages/login_driver_screen.dart';
import 'modules/drivers/dashboard/pages/privacy_policy_page.dart';
import 'modules/users/controllers/user_view_all_blogs_controller.dart';
import 'modules/users/pages/login_user_screen.dart';
import 'modules/users/pages/user_blog_detail_page.dart';
import 'modules/users/pages/user_dashboard_page.dart';
import 'modules/users/pages/user_signup_screen.dart';
import 'modules/users/pages/user_view_all_blogs_page.dart';

appRoutes() {
  return [
    ///admin
    GetPage(
        name: LoginPage.id,
        page: () => LoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<LoginController>(
            () => LoginController(),
          );
        })),
    GetPage(
        name: AdminHomePage.id,
        page: () => AdminHomePage(),
        binding: BindingsBuilder(() {
          /*     Get.lazyPut<AdminHomeScreenController>(
              () => (AdminHomeScreenController));*/
          Get.put(AdminHomeScreenController());
          Get.put(AdminViewAllDriversController());
          Get.put(AdminDashBoardHomeController());
          Get.put(AdminViewAllUsersController());
          Get.put(AdminViewAllBlogsController());
          Get.put(AdminViewAllBookingsController());
          Get.put(NotificationsController());
          Get.put(ChatHomeController());
          Get.put(PromotedAdsController());
        })),
    GetPage(
        name: AdminAddNewBlogPage.id,
        page: () => AdminAddNewBlogPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AdminAddNewBlogController>(
            () => AdminAddNewBlogController(),
          );
        })),

    ///user
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
        page: () => const UserDashboardPage(),
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
        page: () => const PrivacyPolicyPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<PrivacyPolicyController>(
            () => PrivacyPolicyController(),
          );
        })),
    GetPage(
        name: AboutUsPage.id,
        page: () => const AboutUsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AboutUsController>(
            () => AboutUsController(),
          );
        })),
    GetPage(
        name: ContactUsPage.id,
        page: () => const ContactUsPage(),
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
        page: () => const UserViewAllBlogsPage(),
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

    ///driver
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
        page: () => const DriverViewAllBookingsPage(),
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
