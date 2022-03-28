import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/login_driver_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginDriverController>(
      () => LoginDriverController(),
    );
  }
}
