import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DriverHomeController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? motionController;

  var scale;
  var temp = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
  }

  @override
  void dispose() {
    super.dispose();
    motionController?.dispose();
  }
}
