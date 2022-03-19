import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_dashboard_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_dashboard.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/home_page.dart';
import 'package:let_go_gb/modules/drivers/sing_up/controllers/signup_driver_controller.dart';
import 'package:let_go_gb/modules/drivers/sing_up/pages/driver_signup_screen.dart';

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
        page: () => DriverDashBoard(),
        binding: BindingsBuilder(() {
          /*  Get.lazyPut<DriverDashBoardController>(
            () => DriverDashBoardController(),
          );*/

          Get.put(DriverDashBoardController());
        })),
  ];
}
