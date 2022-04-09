import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';

class UserVehicleDetailsController extends GetxController {
  var temp = 0.obs;

  TextEditingController searchController = TextEditingController();
  DriverUserModel? driverModel;
}
