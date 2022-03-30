// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';

class DriverDashBoardHomeRepository {
  late FirebaseHelper _firebaseHelper;
  CollectionReference? _collectionReference;

  DriverDashBoardHomeRepository() {
    _firebaseHelper = FirebaseHelper();
    _collectionReference =
        FirebaseFirestore.instance.collection(FirebasePathNodes.users);
  }

  Future<DriverUserModel> userInfo() async {
    await _collectionReference!
        .doc(UserDefaults.getDriverUserSession()?.id ?? '')
        .get()
        .then((DocumentSnapshot snapshot) {
      Get.log("userInfo: ${snapshot.data()}");

      Map<String, dynamic> userMap = snapshot.data() as Map<String, dynamic>;
      var user = DriverUserModel.fromMap(userMap);

      return user;
    }).catchError((onError) {
      Get.log("$onError", isError: true);

      return DriverUserModel(success: false, errorMessage: "$onError");
    });

    return DriverUserModel(
        success: false, errorMessage: "Something went wrong");
  }
}
