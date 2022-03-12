import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/signup_driver_controller.dart';
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
        }))
  ];
}
