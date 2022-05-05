import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:let_go_gb/common/controller/chat_home_controller.dart';
import 'package:let_go_gb/common/controller/login_controller.dart';
import 'package:let_go_gb/common/controller/notification_controller.dart';
import 'package:let_go_gb/common/pages/login_page.dart';
import 'package:let_go_gb/modules/admin/controller/admin_dashboard_home_controller.dart';
import 'package:let_go_gb/modules/admin/controller/admin_home_controller.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_bookings_controller.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_drivers_controller.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_users_controller.dart';
import 'package:let_go_gb/modules/admin/controller/promoted_vehicles_controller.dart';
import 'package:let_go_gb/modules/admin/pages/blogs_page/admin_add_new_blog_page.dart';
import 'package:let_go_gb/modules/admin/pages/home_page/admin_home_page.dart';

import 'controller/admin_add_new_blog_controller.dart';
import 'controller/admin_view_all_blogs_controller.dart';

adminAppPages() {
  return [
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

    /*  GetPage(
        name: SyncMapShowPage.id,
        page: () => SyncMapShowPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SynMapController>(
            () => SynMapController(),
          );
        })),*/
  ];
}
