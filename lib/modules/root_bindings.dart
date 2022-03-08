import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/controllers/login_driver_controller.dart';
import 'package:let_go_gb/modules/drivers/controllers/signup_driver_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginDriverController>(() => LoginDriverController());
    Get.lazyPut<DriverSignUpController>(() => DriverSignUpController());
  }
}
