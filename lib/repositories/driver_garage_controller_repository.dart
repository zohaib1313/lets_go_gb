
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/dashboard/model/vehicle_model.dart';

import '../modules/drivers/common_widgets/app_preferences.dart';

class DriverGarageRepository {
  late FirebaseHelper _firebaseHelper;
  CollectionReference? _collectionReference;

  DriverGarageRepository() {
    _firebaseHelper = FirebaseHelper();
    _collectionReference = FirebaseFirestore.instance.collection(kUSERS);
  }
  ///.............................Categories...............................////

  Future<VehicleModel?> getVehicles() async {
    try {


      final QuerySnapshot? querySnapshot = await _firebaseHelper
          .firebaseFirestore
          .collection("vehicles")
          .where('AdminId',
          isNotEqualTo: '', isEqualTo: AppPreferences.getUserCredentialsId)
          .get();


        final driverMap = querySnapshot!.docs as Map<String, dynamic>;

       return VehicleModel.fromMap(driverMap);


      //Get.log("Categories: ${VehicleModel.fromMap((e) => e.toMap())}");

    } on FirebaseFirestore catch (onError) {
      Get.log("$onError", isError: true);

      return null;
    } catch (onError) {
      Get.log("$onError", isError: true);

      return null;
    }
  }

}