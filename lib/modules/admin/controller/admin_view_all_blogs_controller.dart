import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/models/BlogsModel.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/utils/app_popups.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';

class AdminViewAllBlogsController extends GetxController {
  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  RxList<BlogModel> filteredItemList = <BlogModel>[].obs;
  final List<BlogModel> allItemList = [];

  void deleteItem({required BlogModel model}) {
    AppPopUps.showConfirmDialog(
        title: "Confirm",
        message: "Are you sure to delete?",
        onSubmit: () async {
          Get.back(result: false);
          isLoading.value = true;
          await FirebaseHelper()
              .deleteDocument(FirebasePathNodes.blogs, model.toMap());
          isLoading.value = false;
        });
  }

  void searchFromList() {
    filteredItemList.clear();
    if (searchController.text.isEmpty) {
      filteredItemList.addAll(allItemList);
    } else {
      String query = searchController.text.toLowerCase();
      for (var element in allItemList) {
        if (((element.placeName ?? "null").toLowerCase()).contains(query) ||
            ((element.placeAddress ?? "null").toLowerCase()).contains(query)) {
          filteredItemList.add(element);
        }
      }
    }
  }
}
