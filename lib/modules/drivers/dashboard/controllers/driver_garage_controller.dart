import 'package:get/get.dart';

class DriverGarageController extends GetxController {
  var temp = 0.obs;
  var haveVehicle = false.obs;

  @override
  void onInit() {
    ///get vehicles on init so that not always new request should be sent while visiting this page
    super.onInit();
  }
}
