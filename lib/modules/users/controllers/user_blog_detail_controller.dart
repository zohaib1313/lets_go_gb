import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserBlogDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var temp = true.obs;

  RxInt selected = 0.obs;
  ScrollController scrollController = ScrollController();

  AnimationController? motionController;
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

  @override
  void dispose() {
    motionController?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    motionController?.dispose();
    super.onClose();
  }
}
