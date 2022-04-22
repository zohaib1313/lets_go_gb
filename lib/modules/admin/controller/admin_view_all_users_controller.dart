import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';

class AdminViewAllUsersController extends GetxController {
  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  RxList<UserModel?> filteredItemList = <UserModel?>[].obs;
  final List<UserModel?> allItemList = [];

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
}
