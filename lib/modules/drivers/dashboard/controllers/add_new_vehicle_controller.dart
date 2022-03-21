import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/model/vehicle_model.dart';

class AddNewVehicleController extends GetxController {
  var temp = 0.obs;

  RxList<File> picturesList = <File>[].obs;

  @override
  void onInit() {
    selectedSeatCapacity.value = seatingCapacityList[0];
    selectedTransmissionType.value = transMissionTypeList[0];
    super.onInit();
  }

  TextEditingController vehicleNameController = TextEditingController();

  Rx<String> selectedSeatCapacity = ''.obs;
  Rx<String> selectedTransmissionType = ''.obs;

  List<String> seatingCapacityList = ['1', '2', '3', '4', '4+'];
  List<String> transMissionTypeList = ['Auto', 'Manual'];

  addVehicle(){

  }

  void resetState() {
    vehicleNameController.clear();
  }


  /// signup model
  VehicleModel _getVehicleModel() {
    /// initialize login model with data

    return VehicleModel(
     vehicleName: vehicleNameController.text,

        );
  }
}
