import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/sing_up/controllers/signup_driver_controller.dart';

import 'dashboard/controllers/driver_home_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverSignUpController>(() => DriverSignUpController());
    Get.lazyPut<DriverHomeController>(() => DriverHomeController());
  }
}
