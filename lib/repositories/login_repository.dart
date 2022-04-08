import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/utils/app_user_roles.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';

import '../modules/drivers/dashboard/models/driver_user_model.dart';

class LoginRepository {
  late FirebaseHelper _firebaseHelper;
  FirebaseAuth? _auth;

  LoginRepository() {
    _firebaseHelper = FirebaseHelper();
    _auth = FirebaseAuth.instance;
  }

  /// User Login Service
  Future<DriverUserModel?> driverLogin(email, password) async {
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

          return _userModel =
              DriverUserModel(success: false, errorMessage: "Failed to login");
        } on FirebaseFirestore catch (onError) {
          Get.log("$onError", isError: true);

          return _userModel =
              DriverUserModel(success: false, errorMessage: "Failed to login");
        } catch (onError) {
          Get.log("$onError", isError: true);

          return _userModel =
              DriverUserModel(success: false, errorMessage: "Failed to login");
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

  Future<UserModel?> userUserLogin(email, password) async {
    UserModel? _userModel;

    try {
      UserCredential userCredential = await _auth!
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        try {
          final userDocument = await _firebaseHelper.getDoc(
              FirebasePathNodes.users, userCredential.user!.uid);

          Map<String, dynamic> userMap =
              userDocument.data() as Map<String, dynamic>;

          if (userMap['userRole'] == AppUserRoles.user) {
            return UserModel.fromMap(userMap);
          }

          _userModel =
              UserModel(success: false, errorMessage: "Failed to login");
        } on FirebaseFirestore catch (onError) {
          Get.log("$onError", isError: true);
          _userModel =
              UserModel(success: false, errorMessage: "Failed to login");
          return null;
        } catch (onError) {
          Get.log("$onError", isError: true);
          _userModel =
              UserModel(success: false, errorMessage: "Failed to login");
          return null;
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.log("$e", isError: true);

      if (e.code == 'user-not-found') {
        _userModel = UserModel(
            success: false, errorMessage: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        _userModel = UserModel(
            success: false,
            errorMessage: "Wrong password provided for that user.");
      }
    }

    return _userModel;
  }
}
