import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../drivers/utils/utils.dart';

class HomeScreenUserController extends GetxController
    with GetTickerProviderStateMixin {
  final loading = true.obs;

  var temp = false.obs;
  AnimationController? motionController;
  var scale;

  HomeScreenUserController();

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

  @override
  void dispose() {
    printWrapped("disposed called");
    motionController!.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    printWrapped("close called");
    motionController!.dispose();
    super.onClose();
  }
}
