import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/dashboard/model/vehicle_model.dart';
import 'package:let_go_gb/repositories/vehicle_repository.dart';

class AddNewVehicleController extends GetxController {
  var temp = 0.obs;

  RxList<File> picturesList = <File>[].obs;
  final loading = false.obs;
  VehicleRepository? _vehicleRepository;

  @override
  void onInit() {
    selectedSeatCapacity.value = seatingCapacityList[0];
    selectedTransmissionType.value = transMissionTypeList[0];
    _vehicleRepository = VehicleRepository();
    super.onInit();
  }

  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController vehicleMakerController = TextEditingController();
  TextEditingController vehicleMakeController = TextEditingController();
  TextEditingController vehicleRentHourController = TextEditingController();
  TextEditingController vehicleMileageController = TextEditingController();
  TextEditingController vehicleNotesDescriptionController =
      TextEditingController();

  Rx<String> selectedSeatCapacity = ''.obs;
  Rx<String> selectedTransmissionType = ''.obs;

  List<String> seatingCapacityList = ['1', '2', '3', '4', '4+'];
  List<String> transMissionTypeList = ['Auto', 'Manual'];
  List<String> vehicleImages = [];

  addVehicle() {}

  void resetState() {
    vehicleNameController.clear();
  }

  /// signup model
  VehicleModel _getVehicleModel() {
    /// initialize login model with data

    return VehicleModel(
        vehicleName: vehicleNameController.text,
        plateNo: vehicleNoController.text,
        make: vehicleMakeController.text,
        maker: vehicleMakerController.text,
        rentHour: vehicleRentHourController.text,
        mileage: vehicleMileageController.text,
        seatingCapacity: selectedSeatCapacity.value,
        transmissionType: selectedTransmissionType.value,
        //vehicleImages: ,
        success: true,
        errorMessage: "Success");
  }

  void saveVehicle() {
    loading.value = true;
    _vehicleRepository!.saveVehicle(_getVehicleModel()).then((value) {
      if (value.toString() == "Success") {
        Get.back();
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: "Vehicle Added Successfully"));
      }
    }).catchError((onError) {
      Get.log(onError.toString(), isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: onError.toString()));
    }).whenComplete(() {
      loading.value = false;
    });
  }
}
