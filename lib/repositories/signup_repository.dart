import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/app_preferences.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/sing_up/models/signup_model.dart';
class SignupRepository{
  late FirebaseHelper _firebaseHelper;

  SignupRepository() {

    _firebaseHelper = FirebaseHelper();

  }

  Future<bool> getUsersWithSamePhone(String phoneNo, String id) async {


    try {

      final QuerySnapshot? querySnapshot  = await  _firebaseHelper.firebaseFirestore
          .collection(kUSERS)
          .where('Id',isNotEqualTo: id)
          .where('AdminId',isEqualTo: AppPreferences.getUserCredentialsId)
          .where('Phone', isEqualTo: phoneNo).get();

      if(querySnapshot!.docs.isNotEmpty){
        return true;

      }
      return false;


    } on FirebaseFirestore catch(onError) {

      Get.log("$onError", isError: true);

      return false;

    } catch(onError) {

      Get.log("$onError", isError: true);

      return false;
    }

  }
/// save users
  Future<String> saveUser(SignUpModel userModel) async {

    try{

      UserCredential userCredential = await _firebaseHelper.createUser(userModel.emailAddress!, userModel.password!);

      if(userCredential.user != null){

        userModel.id = userCredential.user!.uid;

        userModel.adminId = AppPreferences.getUserCredentialsId;

        try{

          final isSuccess = await _firebaseHelper.saveDocument(kUSERS, userModel.toJson());

          if(isSuccess){


            return "Success";

          }else{

            return "Failed to save user";

          }

        } on FirebaseFirestore catch(onError){

          Get.log("$onError", isError: true);

          return onError.toString();

        } catch(onError) {

          Get.log("$onError", isError: true);

          return "Failed to save user";
        }



      }else{

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