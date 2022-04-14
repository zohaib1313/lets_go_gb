import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:let_go_gb/modules/admin/controller/admin_home_controller.dart';
import 'package:let_go_gb/modules/admin/controller/admin_login_controller.dart';
import 'package:let_go_gb/modules/admin/pages/admin_home_screen.dart';
import 'package:let_go_gb/modules/admin/pages/admin_login_page/admin_login_page.dart';

adminAppPages() {
  return [
    GetPage(
        name: AdminHomeScreen.id,
        page: () => AdminHomeScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AdminHomeScreenController>(
            () => AdminHomeScreenController(),
          );
        })),
    GetPage(
        name: AdminLoginPage.id,
        page: () => AdminLoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AdminLoginController>(
            () => AdminLoginController(),
          );
        })),
  ];
}
