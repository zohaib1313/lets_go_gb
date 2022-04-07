import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';

class SignupRepository {
  late FirebaseHelper firebaseHelper;

  SignupRepository() {
    firebaseHelper = FirebaseHelper();
  }

  Future<bool> checkUserIfExistsOnMail(String email) async {
    try {
      final QuerySnapshot? querySnapshot = await firebaseHelper
          .firebaseFirestore
          .collection(FirebasePathNodes.users)
          .where('emailAddress', isEqualTo: email)
          .get();

      if (querySnapshot!.docs.isNotEmpty) {
        return true;
      }
      return false;
    } on FirebaseFirestore catch (onError) {
      Get.log("$onError", isError: true);

      return false;
    } catch (onError) {
      Get.log("$onError", isError: true);

      return false;
    }
  }

  /// save users
  Future<String> saveDriverUser(DriverUserModel userModel) async {
    try {
      UserCredential userCredential = await firebaseHelper.createUser(
          userModel.emailAddress!, userModel.password!);

      if (userCredential.user != null) {
        userModel.id = userCredential.user!.uid;

        try {
          final isSuccess = await firebaseHelper.saveDocument(
              FirebasePathNodes.users, userModel.toMap());

          if (isSuccess) {
            return "Success";
          } else {
            return "Failed to save user";
          }
        } on FirebaseFirestore catch (onError) {
          Get.log("$onError", isError: true);

          return onError.toString();
        } catch (onError) {
          Get.log("$onError", isError: true);

          return "Failed to save user";
        }
      } else {
        return "Failed to save user";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.log('The password provided is too weak.', isError: true);

        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        Get.log('The account already exists for that email.', isError: true);

        return 'The account already exists for that email.';
      }
    } catch (e) {
      Get.log('$e', isError: true);

      return "Failed to save user";
    }

    return "";
  }

  /// update driver users
  Future<String> updateDriverUser(DriverUserModel userModel) async {
    try {
      final isSuccess = await firebaseHelper.updateDocument(
          FirebasePathNodes.users, userModel.toMap());

      if (isSuccess) {
        return "Success";
      } else {
        return "Failed to update user";
      }
    } on FirebaseFirestore catch (onError) {
      Get.log("$onError", isError: true);

      return onError.toString();
    } catch (onError) {
      Get.log("$onError", isError: true);

      return "Failed to update user";
    }
  }

  /// save users
  Future<String> saveUserUser(UserModel userModel) async {
    try {
      UserCredential userCredential = await firebaseHelper.createUser(
          userModel.emailAddress!, userModel.password!);

      if (userCredential.user != null) {
        userModel.id = userCredential.user!.uid;

        try {
          final isSuccess = await firebaseHelper.saveDocument(
              FirebasePathNodes.users, userModel.toMap());

          if (isSuccess) {
            return "Success";
          } else {
            return "Failed to save user";
          }
        } on FirebaseFirestore catch (onError) {
          Get.log("$onError", isError: true);

          return onError.toString();
        } catch (onError) {
          Get.log("$onError", isError: true);

          return "Failed to save user";
        }
      } else {
        return "Failed to save user";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.log('The password provided is too weak.', isError: true);

        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        Get.log('The account already exists for that email.', isError: true);

        return 'The account already exists for that email.';
      }
    } catch (e) {
      Get.log('$e', isError: true);

      return "Failed to save user";
    }

    return "";
  }
}
