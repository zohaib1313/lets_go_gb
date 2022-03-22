import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/dashboard/model/vehicle_model.dart';

class VehicleRepository{
  late FirebaseHelper _firebaseHelper;

  VehicleRepository() {
    _firebaseHelper = FirebaseHelper();
  }


  Future<String?> saveVehicle(VehicleModel model) async {
    try {
      final isSuccess =
      await _firebaseHelper.saveDocument(kVEHICLES, model.toMap());

      if (isSuccess) {
        return Future.value("Success");
      } else {
        return Future.value("Failed to save product");
      }
    } on FirebaseFirestore catch (onError) {
      Get.log("$onError", isError: true);

      return Future.value(onError.toString());
    } catch (onError) {
      Get.log("$onError", isError: true);

      return Future.value("Failed to save product");
    }



}
}