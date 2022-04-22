import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';

class AdminViewAllDriversController extends GetxController {
  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  RxList<DriverUserModel?> filteredItemList = <DriverUserModel?>[].obs;
  final List<DriverUserModel?> allItemList = [];

  void searchFromList() {
    filteredItemList.clear();
    if (searchController.text.isEmpty) {
      filteredItemList.addAll(allItemList);
    } else {
      String query = searchController.text.toLowerCase();
      for (var element in allItemList) {
        if (((element?.firstName ?? "null").toLowerCase()).contains(query) ||
            ((element?.phone ?? "null").toLowerCase()).contains(query) ||
            ((element?.emailAddress ?? "null").toLowerCase()).contains(query)) {
          filteredItemList.add(element);
        }
      }
    }
  }

  void changeDriverAccountStatus({required DriverUserModel model}) async {
    isLoading.value = true;
    var updatedModel = model.copyWith(isActive: (!(model.isActive ?? false)));
    await FirebaseHelper()
        .updateDocument(FirebasePathNodes.users, updatedModel.toMap());
    isLoading.value = false;
  }
}
