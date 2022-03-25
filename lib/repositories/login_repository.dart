import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/utils/app_user_roles.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';

import '../modules/drivers/sing_up/models/signup_model.dart';

class LoginRepository {
  late FirebaseHelper _firebaseHelper;
  FirebaseAuth? _auth;

  LoginRepository() {
    _firebaseHelper = FirebaseHelper();
    _auth = FirebaseAuth.instance;
  }

  /// User Login Service
  Future<DriverUserModel?> userLogin(email, password) async {
    DriverUserModel? _userModel;

    try {
      UserCredential userCredential = await _auth!
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        try {
          final userDocument = await _firebaseHelper.getDoc(
              FirebasePathNodes.users, userCredential.user!.uid);

          Map<String, dynamic> userMap =
              userDocument.data() as Map<String, dynamic>;

          if (userMap['userRole'] == AppUserRoles.driver) {
            return DriverUserModel.fromMap(userMap);
          }

          return null;
        } on FirebaseFirestore catch (onError) {
          Get.log("$onError", isError: true);

          return null;
        } catch (onError) {
          Get.log("$onError", isError: true);

          return null;
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.log("$e", isError: true);

      if (e.code == 'user-not-found') {
        _userModel = DriverUserModel(
            success: false, errorMessage: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        _userModel = DriverUserModel(
            success: false,
            errorMessage: "Wrong password provided for that user.");
      }
    }

    return _userModel;
  }
}
