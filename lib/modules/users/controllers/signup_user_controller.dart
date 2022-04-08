import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/utils/app_user_roles.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';
import 'package:let_go_gb/repositories/signup_repository.dart';

class UserSignUpController extends GetxController {
  var formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final loading = false.obs;

  SignupRepository? _signupRepository;

  File? profileImage;

  String password = "";
  RxBool hidePasswordOne = true.obs;
  RxBool hideConfirmPassword = true.obs;
  RxBool haveProfileImage = false.obs;

  @override
  void onInit() {
    _signupRepository = SignupRepository();

    super.onInit();
  }

  void resetState() {
    firstNameController.clear();
    contactNumberController.clear();
    addressController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailController.clear();
  }

  /// save User
  Future<void> saveUser() async {
    loading.value = true;
    uploadImagesToFireStorage(complete: (user) {
      _signupRepository!.saveUserUser(user).then((value) {
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
    });
  }

  void uploadImagesToFireStorage({complete}) async {
    String email = emailController.text.trim();

    String profileImageUrl = await _signupRepository!.firebaseHelper
        .uploadImage(
            file: File(profileImage?.path ?? ''),
            fileName: 'profilePic',
            path: FirebasePathNodes.usersImages + email);

    var user = UserModel(
      password: passwordController.text.trim(),
      address: addressController.text.trim(),
      success: true,
      errorMessage: "Success",
      deviceTokenId: await FirebaseMessaging.instance.getToken(),
      emailAddress: email,
      profileImage: profileImageUrl,
      firstName: firstNameController.text.trim(),
      phone: contactNumberController.text.trim(),
      userRole: AppUserRoles.user,
      isActive: false,
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

  pickProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'png',
        ],
        allowMultiple: false);
    haveProfileImage.value = false;
    if (result != null) {
      File file = File(result.files.single.path!);
      profileImage = file;
    } else {
      // User canceled the picker
    }
    haveProfileImage.value = profileImage != null;
  }
}
