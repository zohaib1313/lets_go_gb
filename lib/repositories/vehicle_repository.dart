import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';

import '../modules/drivers/utils/firebase_paths.dart';

class VehicleRepository {
  late FirebaseHelper firebaseHelper;

  VehicleRepository() {
    firebaseHelper = FirebaseHelper();
  }

  Future<String?> saveVehicle(VehicleModel model) async {
    try {
      final isSuccess = await firebaseHelper.saveDocument(
          FirebasePathNodes.vehicles, model.toMap());

      if (isSuccess) {
        return Future.value("Success");
      } else {
        return Future.value("Failed to save vehicle");
      }
    } on FirebaseFirestore catch (onError) {
      Get.log("$onError", isError: true);

      return Future.value(onError.toString());
    } catch (onError) {
      Get.log("$onError", isError: true);

      return Future.value("Failed to save vehicle");
    }
  }
}
