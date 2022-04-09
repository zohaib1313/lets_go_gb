import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/dropdown.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';
import 'package:let_go_gb/modules/drivers/utils/app_user_roles.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/repositories/signup_repository.dart';

class DriverSignUpController extends GetxController {
  var formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final loading = false.obs;

  final statusDropDown = Dropdown().obs;
  List<Dropdown> statusDropDownList = [];
  SignupRepository? _signupRepository;

  File? cnicFrontFile;
  File? cnicBackFile;

  File? drivingLicenceFile;
  String password = "";
  RxBool hidePasswordOne = true.obs;
  RxBool hideConfirmPassword = true.obs;
  Rxn<File?> profileImage = Rxn<File>();

  @override
  void onInit() {
    // TODO: implement onInit
    _signupRepository = SignupRepository();
    loadStatusDropdown();
    super.onInit();
  }

  void resetState() {
    firstNameController.clear();
    contactNumberController.clear();
    addressController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailController.clear();
    cnicFrontFile = null;
    cnicBackFile = null;
    drivingLicenceFile = null;
    statusDropDown.value = statusDropDownList.first;
  }

  /// map of status list
  Map<String, int> _getStatusMap() {
    return {
      "Active": 1,
      "InActive": 2,
    };
  }

  /// load paid status list
  Future<void> loadStatusDropdown() async {
    List<Dropdown> _list = [];

    _getStatusMap().forEach((key, value) {
      _list.add(Dropdown(name: key, id: value));
    });

    if (_list.isNotEmpty) {
      statusDropDownList = _list;

      statusDropDown.value = _list.first;
    }
  }

  /// save User
  Future<void> setUser(DriverUserModel? driverUserModel) async {
    loading.value = true;
    uploadImagesToFireStorage(
        driverUserModel: driverUserModel,
        complete: (DriverUserModel user) {
          if (driverUserModel != null) {
            user.id = driverUserModel.id ?? '';
            _signupRepository!.updateDriverAndUser(user.toMap()).then((value) {
              if (value == "Success") {
                Get.back();
                Get.showSnackbar(
                    Ui.SuccessSnackBar(message: "User updated successfully"));
              } else {
                Get.showSnackbar(Ui.ErrorSnackBar(message: value));
              }
            }).whenComplete(() {
              loading.value = false;
            });
          } else {
            _signupRepository!.saveDriverUser(user).then((value) {
              if (value == "Success") {
                Get.back();
                Get.showSnackbar(
                    Ui.SuccessSnackBar(message: "User Added successfully"));
              } else {
                Get.showSnackbar(Ui.ErrorSnackBar(message: value));
              }
            }).whenComplete(() {
              loading.value = false;
            });
          }
        });
  }

  void uploadImagesToFireStorage(
      {complete, DriverUserModel? driverUserModel}) async {
    String email = emailController.text.trim();

    String profileImageUrl = driverUserModel?.profileImage ?? '';
    if (profileImage.value != null) {
      profileImageUrl = await _signupRepository!.firebaseHelper.uploadImage(
          file: File(profileImage.value!.path ?? ''),
          fileName: 'profilePic',
          path: FirebasePathNodes.driverImages + email);
    }

    String cnincFrontUrl = driverUserModel?.cnicFrontImageUrl ?? '';
    if (cnicFrontFile != null) {
      cnincFrontUrl = await _signupRepository!.firebaseHelper.uploadImage(
          file: File(cnicFrontFile?.path ?? ''),
          fileName: 'cnicFront',
          path: FirebasePathNodes.driverImages + email);
    }
    String cnincBackUrl = driverUserModel?.cnicBackImageUrl ?? '';
    if (cnicBackFile != null) {
      cnincBackUrl = await _signupRepository!.firebaseHelper.uploadImage(
          file: File(cnicBackFile?.path ?? ''),
          fileName: 'cnicBack',
          path: FirebasePathNodes.driverImages + email);
    }

    String drivingLicenseUrl = driverUserModel?.driverLicenceImageUrl ?? "";
    if (drivingLicenceFile != null) {
      drivingLicenseUrl = await _signupRepository!.firebaseHelper.uploadImage(
          fileName: 'drivingLicense',
          file: File(drivingLicenceFile?.path ?? ''),
          path: FirebasePathNodes.driverImages + email);
    }

    var user = DriverUserModel(
      password: passwordController.text.trim(),
      address: addressController.text.trim(),
      errorMessage: "Success",
      deviceTokenId: await FirebaseMessaging.instance.getToken(),
      success: true,
      emailAddress: email,
      profileImage: profileImageUrl,
      firstName: firstNameController.text.trim(),
      phone: contactNumberController.text.trim(),
      userRole: AppUserRoles.driver,
      isActive: false,
      cnicFrontImageUrl: cnincFrontUrl,
      cnicBackImageUrl: cnincBackUrl,
      driverLicenceImageUrl: drivingLicenseUrl,
    );

    printWrapped(user.toString());
    complete(user);
  }

  void checkIfAccountAlreadyExists({complete}) async {
    printWrapped('checking if user already exists');
    loading.value = true;
    var result = await _signupRepository!
        .checkUserIfExistsOnMail(emailController.text.trim());
    loading.value = false;
    printWrapped('checking already exists= ${result}');
    if (result) {
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'User with same email already exists'));
    } else {
      complete();
    }
  }

  void setValuesWithUpdated(DriverUserModel driverUserModel) {
    addressController.text = driverUserModel.address ?? '';
    firstNameController.text = driverUserModel.firstName ?? '';
    contactNumberController.text = driverUserModel.phone ?? '';
    emailController.text = driverUserModel.emailAddress ?? '';
  }

/*void _changePassword(String password) async {
    User? user =   FirebaseAuth.instance.currentUser;

    String? email = user?.email;

    //Create field for user to input old password

    //pass the password here
    String password = "password";
    String newPassword = "password";

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password,
      );

      user?.updatePassword(newPassword).then((_){

      }).catchError((error){

      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }*/
}
