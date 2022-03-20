import 'package:get/get.dart';
import 'package:let_go_gb/modules/users/home/controllers/login_driver_controller.dart';


class LoginBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<LoginUserController>(
          () => LoginUserController(),
    );
  }

}