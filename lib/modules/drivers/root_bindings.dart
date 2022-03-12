import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/signup_driver_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverSignUpController>(() => DriverSignUpController());
  }
}
