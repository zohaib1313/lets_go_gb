
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/app_preferences.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/sing_in/models/login_model.dart';

class DriverDashBoardHomeRepository {
  late FirebaseHelper _firebaseHelper;
    CollectionReference? _collectionReference;

  DriverDashBoardHomeRepository() {
    _firebaseHelper = FirebaseHelper();
    _collectionReference = FirebaseFirestore.instance.collection(kUSERS);
  }

  Future<UserModel> userInfo() async {

    final userId = AppPreferences.getUserCredentialsId;

    if(userId != null){

      return _collectionReference!.doc(userId)
          .get()
          .then((DocumentSnapshot snapshot){

        Get.log("userInfo: ${snapshot.data()}");

        Map<String,dynamic> userMap = snapshot.data() as Map<String,dynamic>;

        return UserModel.fromJson(userMap);

      }).catchError((onError){

        Get.log("$onError",isError: true);

        return UserModel(success: false,errorMessage: "$onError");

      });
    }

    return UserModel(success: false,errorMessage: "Something went wrong");
  }


}