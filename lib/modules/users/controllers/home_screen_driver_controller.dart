import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';

import '../../drivers/utils/common_widgets.dart';
import '../../drivers/utils/user_defaults.dart';
import '../../drivers/utils/utils.dart';

class HomeScreenUserController extends GetxController
    with GetTickerProviderStateMixin {
  final loading = true.obs;

  AnimationController? motionController;
  var scale;

  RxList<VehicleModel?> promotedVehicles = <VehicleModel?>[].obs;

  HomeScreenUserController();

  var notificationsCounts = 0.obs;

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

    _loadPromotedVehicles();
    _readNotificationsCount();
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

  void _readNotificationsCount() {
    FirebaseFirestore.instance
        .collection(FirebasePathNodes.notifications)
        .where('toId', isEqualTo: UserDefaults.getCurrentUserId())
        .where('isRead', isEqualTo: false)
        .snapshots()
        .listen((QuerySnapshot event) {
      notificationsCounts.value = event.docs.length;
    });
  }

  void _loadPromotedVehicles() {
    promotedVehicles.clear();

    FirebaseFirestore.instance
        .collection(FirebasePathNodes.promotedVehicles)
        .doc('ids')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      Map<String, dynamic>? map = snapshot.data() as Map<String, dynamic>;
      printWrapped('promoted vehicles');

      for (var element in map.keys) {
        FirebaseFirestore.instance
            .collection(FirebasePathNodes.vehicles)
            .doc(element)
            .get()
            .then((DocumentSnapshot vehicleSnapshot) {
          VehicleModel vehicleModel = VehicleModel.fromMap(
              vehicleSnapshot.data() as Map<String, dynamic>);
          promotedVehicles.add(vehicleModel);
        });
      }
    });
  }

  List<Widget> imagesList() {
    List<Widget> list = [];
    for (var element in promotedVehicles) {
      element?.vehicleImages?.forEach((images) {
        list.add(ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: NetworkPlainImage(
              url: images,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ));
      });
    }
    return list;
  }
}
