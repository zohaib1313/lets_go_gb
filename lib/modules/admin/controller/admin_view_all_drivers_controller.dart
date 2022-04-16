import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../drivers/dashboard/models/vehicle_model.dart';

class AdminViewAllDriversController extends GetxController {
  var temp = 0.obs;

  TextEditingController searchController = TextEditingController();

  RxList<VehicleModel?> filteredItemList = <VehicleModel?>[].obs;
  final List<VehicleModel?> allItemList = [];

  void searchFromList() {
    filteredItemList.clear();
    if (searchController.text.isEmpty) {
      filteredItemList.addAll(allItemList);
    } else {
      String query = searchController.text.toLowerCase();
      for (var element in allItemList) {
        if (((element?.vehicleName ?? "null").toLowerCase()).contains(query) ||
            ((element?.transmissionType ?? "null").toLowerCase())
                .contains(query) ||
            ((element?.rent ?? "null").toLowerCase()).contains(query) ||
            ((element?.make ?? "null").toLowerCase()).contains(query) ||
            ((element?.maker ?? "null").toLowerCase()).contains(query)) {
          filteredItemList.add(element);
        }
      }
    }
  }
}
