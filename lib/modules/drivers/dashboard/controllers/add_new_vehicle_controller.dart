import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/dashboard/model/vehicle_model.dart';
import 'package:let_go_gb/repositories/vehicle_repository.dart';

class AddNewVehicleController extends GetxController {
  var temp = 0.obs;

  RxList<File> picturesList = <File>[].obs;
  RxList<String> feature = <String>[].obs;
  final loading = false.obs;
  VehicleRepository? _vehicleRepository;
  FirebaseHelper? firebaseHelper;

  @override
  void onInit() {
    selectedSeatCapacity.value = seatingCapacityList[0];
    selectedTransmissionType.value = transMissionTypeList[0];
    _vehicleRepository = VehicleRepository();
    firebaseHelper = FirebaseHelper();
    super.onInit();
  }


  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController vehicleMakerController = TextEditingController();
  TextEditingController vehicleMakeController = TextEditingController();
  TextEditingController vehicleRentHourController = TextEditingController();
  TextEditingController vehicleMileageController = TextEditingController();

  TextEditingController vehicleNotesDescriptionController = TextEditingController();


  Rx<String> selectedSeatCapacity = ''.obs;
  Rx<String> selectedTransmissionType = ''.obs;

  List<String> seatingCapacityList = ['1', '2', '3', '4', '4+'];
  List<String> transMissionTypeList = ['Auto', 'Manual'];
  List<String> vehicleImages = [];



  void resetState() {
    vehicleNameController.clear();
  }


  /// signup model
  VehicleModel _getVehicleModel(vehicleImagesPath) {
    /// initialize login model with data
    final uid = const Uuid().v4();
    return VehicleModel(
      id: uid,
     vehicleName: vehicleNameController.text,
      plateNo: vehicleNoController.text,
      make: vehicleMakeController.text,
      maker: vehicleMakerController.text,
      rentHour: vehicleRentHourController.text,
      mileage: vehicleMileageController.text,
      descriptionNote: vehicleNotesDescriptionController.text,
      seatingCapacity: selectedSeatCapacity.value,
      transmissionType: selectedTransmissionType.value,
    features: feature,
      vehicleImages: vehicleImagesPath,
      success: true,
      errorMessage: "Success"





        );
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
                      _pickImage( source: 0);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage( source: 1);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
  void _pickImage({ required int source}) async {


    try {
      final pickedFile = await ImagePicker().pickImage(
          source: source == 1 ? ImageSource.camera : ImageSource.gallery);

      if (pickedFile != null) {
        picturesList.add(File(pickedFile.path));
        Get.log("kkkkkkkk");
      } else {
        Get.log('No image selected.');
      }
    } catch (e) {

      Get.log(e.toString(), isError: true);
    }
  }

  Future<List<String>> uploadFiles(List<File> _images) async {
    var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image)));
    print(imageUrls);
    return imageUrls;
  }

  Future<String> uploadFile(File _image) async {
    dynamic storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${_image.path}');
    dynamic uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;

    return await storageReference.getDownloadURL();
  }

   Future<void> saveVehicle() async{
    loading.value = true;


     //await imagePicker();
     List<String> _list = await uploadFiles(picturesList);


    _vehicleRepository!.saveVehicle(_getVehicleModel(_list)).then((value) {
      if (value.toString() == "Success")
      {

      Get.back();
      Get.showSnackbar(Ui.SuccessSnackBar(
      message: "Vehicle Added Successfully"));
    }
    }).catchError((onError) {
      Get.log(onError.toString(), isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: onError.toString()));
    }).whenComplete(() {
      loading.value = false;
    });
  }
}
