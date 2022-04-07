import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/repositories/vehicle_repository.dart';
import 'package:path/path.dart';

class AddNewVehicleController extends GetxController {
  var temp = 0.obs;

  RxList<File> picturesList = <File>[].obs;
  RxList<String> feature = <String>[].obs;

  RxList<String> networkImageList = <String>[].obs;
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

  void resetState() {
    vehicleNameController.clear();
  }

  /// signup model

  Future<void> saveVehicle(VehicleModel? vehicleModel) async {
    loading.value = true;
    String id = UserDefaults.getDriverUserSession()?.id ?? '';

    uploadImagesToFireStorage(
        id: id,
        onComplete: (List<String> vehiclesImagesUrls) {
          ///this will set previous images list if being updated
          vehiclesImagesUrls.addAll(networkImageList);
          VehicleModel model = VehicleModel(
              id: id,
              vehicleName: vehicleNameController.text,
              plateNo: vehicleNoController.text,
              make: vehicleMakeController.text,
              maker: vehicleMakerController.text,
              rent: vehicleRentHourController.text,
              mileage: vehicleMileageController.text,
              descriptionNote: vehicleNotesDescriptionController.text,
              seatingCapacity: selectedSeatCapacity.value,
              transmissionType: selectedTransmissionType.value,
              features: feature,
              vehicleImages: vehiclesImagesUrls,
              success: true,
              errorMessage: "Success");

          if (vehicleModel != null) {
            _vehicleRepository!.updateVehicle(model).then((value) {
              if (value.toString() == "Success") {
                Get.back();
                Get.showSnackbar(Ui.SuccessSnackBar(
                    message: "Vehicle Updated Successfully"));
              }
            }).catchError((onError) {
              Get.log(onError.toString(), isError: true);
              Get.showSnackbar(Ui.ErrorSnackBar(message: onError.toString()));
            }).whenComplete(() {
              loading.value = false;
            });
          } else {
            _vehicleRepository!.saveVehicle(model).then((value) {
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
        });
  }

  void showPicker({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext x) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _pickImage(source: 0);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage(source: 1);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void _pickImage({required int source}) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
          source: source == 1 ? ImageSource.camera : ImageSource.gallery);

      if (pickedFile != null) {
        picturesList.add(File(pickedFile.path));
      } else {
        Get.log('No image selected.');
      }
    } catch (e) {
      Get.log(e.toString(), isError: true);
    }
  }

  void uploadImagesToFireStorage({required String id, onComplete}) async {
    List<String> imagesUrl = [];
    await Future.forEach(picturesList, (element) async {
      String url = await _vehicleRepository!.firebaseHelper.uploadImage(
          file: element as File,
          fileName: basename((element).path),
          path: FirebasePathNodes.vehicles + "/" + id + "/");
      imagesUrl.add(url);
    });

    printWrapped('on Complete called');
    onComplete(imagesUrl);
  }

  void setUpdatedValues(VehicleModel vehicleModel) {
    vehicleNameController.text = vehicleModel.vehicleName ?? '-';
    vehicleNoController.text = vehicleModel.plateNo ?? '';
    vehicleMakeController.text = vehicleModel.make ?? '';
    vehicleMakerController.text = vehicleModel.maker ?? '';
    vehicleRentHourController.text = vehicleModel.rent ?? '';
    vehicleMileageController.text = vehicleModel.mileage ?? '';
    vehicleNotesDescriptionController.text = vehicleModel.descriptionNote ?? '';
    selectedSeatCapacity.value = vehicleModel.seatingCapacity ?? "1";
    selectedTransmissionType.value = vehicleModel.transmissionType ?? 'Manual';
    vehicleModel.features?.forEach((element) {
      feature.add(element.toString());
    });
    vehicleModel.vehicleImages?.forEach((element) {
      networkImageList.add(element);
    });
  }

  void updateVehicle() {}
}
