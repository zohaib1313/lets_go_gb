import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/sing_in/models/login_model.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/repositories/driver_dashboard_home_repository.dart';

class DriverDashBoardHomeController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? motionController;
  final loginModel = UserDefaults.getUserSession();
  DriverDashBoardHomeRepository? _homeRepository;
  DriverDashBoardHomeController() {
    _homeRepository = DriverDashBoardHomeRepository();
  }
  final loading = false.obs;
  var scale;

  @override
  void onInit() {
    motionController = AnimationController(
        duration: const Duration(seconds: 15),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 0.3);
    motionController?.forward();
    motionController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        motionController?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        motionController?.forward();
      }
    });
    super.onInit();
  }

  /// User Info Service
  void loadUserInfo() {
    loading.value = true;
    _homeRepository!.userInfo().then((value) {
      _userInfoResponse(value);
    }).catchError((onError) {
      Get.log("$onError", isError: true);

      Get.showSnackbar(Ui.ErrorSnackBar(message: "$onError"));
    }).whenComplete(() {
      loading.value = false;
    });
  }

  void _userInfoResponse(UserModel value) {
    if (value.success!) {
      //loginModel.value = value;
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "${value.errorMessage}"));
    }
  }

  @override
  void dispose() {
    printWrapped("disposed called");
    motionController!.dispose();
    super.dispose();
  }
}
