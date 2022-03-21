import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/sing_in/controllers/login_driver_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginDriverController>(
      () => LoginDriverController(),
    );
  }
}
