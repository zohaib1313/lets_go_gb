import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
  File? profileImage;

  File? drivingLicenceFile;
  String password = "";
  RxBool hidePasswordOne = true.obs;
  RxBool hideConfirmPassword = true.obs;
  RxBool haveProfileImage = false.obs;

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
  Future<void> saveUser() async {
    loading.value = true;
    uploadImagesToFireStorage(complete: (user) {
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
    });
  }

  void uploadImagesToFireStorage({complete}) async {
    String email = emailController.text.trim();

    String profileImageUrl = await _signupRepository!.firebaseHelper
        .uploadImage(
            file: File(profileImage?.path ?? ''),
            fileName: 'profilePic',
            path: FirebasePathNodes.driverImages + email);

    String cnincFrontUrl = await _signupRepository!.firebaseHelper.uploadImage(
        file: File(cnicFrontFile?.path ?? ''),
        fileName: 'cnicFront',
        path: FirebasePathNodes.driverImages + email);

    String cnincBackUrl = await _signupRepository!.firebaseHelper.uploadImage(
        file: File(cnicBackFile?.path ?? ''),
        fileName: 'cnicBack',
        path: FirebasePathNodes.driverImages + email);
    String drivingLicenseUrl = await _signupRepository!.firebaseHelper
        .uploadImage(
            fileName: 'drivingLicense',
            file: File(drivingLicenceFile?.path ?? ''),
            path: FirebasePathNodes.driverImages + email);

    var user = DriverUserModel(
      password: passwordController.text.trim(),
      address: addressController.text.trim(),
      errorMessage: "Success",
      success: true,
      emailAddress: email,
      profileImage: profileImageUrl,
      firstName: firstNameController.text.trim(),
      phone: contactNumberController.text.trim(),
      userRole: AppUserRoles.driver,
      isActive: false,
      ratings: 0,
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
