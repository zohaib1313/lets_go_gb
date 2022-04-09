import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Rxn<File?> profileImage = Rxn<File>();

  String password = "";
  RxBool hidePasswordOne = true.obs;
  RxBool hideConfirmPassword = true.obs;

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
  Future<void> setUser({UserModel? userModel}) async {
    loading.value = true;
    uploadImagesToFireStorage(
        userModel: userModel,
        complete: (UserModel user) {
          if (userModel != null) {
            user.id = userModel.id ?? '';
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
            _signupRepository!.saveUserUser(user).then((value) {
              if (value == "Success") {
                Get.back();
                Get.showSnackbar(
                    Ui.SuccessSnackBar(message: "User added successfully"));
              } else {
                Get.showSnackbar(Ui.ErrorSnackBar(message: value));
              }
            }).whenComplete(() {
              loading.value = false;
            });
          }
        });
  }

  void uploadImagesToFireStorage({complete, UserModel? userModel}) async {
    String email = emailController.text.trim();
    String profileImageUrl = userModel?.profileImage ?? '';
    if (profileImage.value != null) {
      profileImageUrl = await _signupRepository!.firebaseHelper.uploadImage(
          file: File(profileImage.value?.path ?? ''),
          fileName: 'profilePic',
          path: FirebasePathNodes.usersImages + email);
    }
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
    printWrapped('checking already exists= $result');
    if (result) {
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'User with same email already exists'));
    } else {
      complete();
    }
  }

  // void showPicker({required BuildContext context}) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext x) {
  //         return SafeArea(
  //           child: Wrap(
  //             children: <Widget>[
  //               ListTile(
  //                   leading: const Icon(Icons.photo_library),
  //                   title: const Text('Photo Library'),
  //                   onTap: () {
  //                     _pickImage(source: 0);
  //                     Navigator.of(context).pop();
  //                   }),
  //               ListTile(
  //                 leading: const Icon(Icons.photo_camera),
  //                 title: const Text('Camera'),
  //                 onTap: () {
  //                   _pickImage(source: 1);
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
  //
  // void _pickImage({required int source}) async {
  //   try {
  //     final pickedFile = await ImagePicker().pickImage(
  //         source: source == 1 ? ImageSource.camera : ImageSource.gallery);
  //
  //     if (pickedFile != null) {
  //       profileImage = File(pickedFile.path);
  //     } else {
  //       Get.log('No image selected.');
  //     }
  //     haveProfileImage.value = profileImage != null;
  //   } catch (e) {
  //     Get.log(e.toString(), isError: true);
  //   }
  // }

  void setValuesForUpdate(UserModel userModel) {
    addressController.text = userModel.address ?? '';
    firstNameController.text = userModel.firstName ?? '';
    contactNumberController.text = userModel.phone ?? '';
    emailController.text = userModel.emailAddress ?? '';
  }
}
