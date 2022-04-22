import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:uuid/uuid.dart';

import '../../drivers/common_widgets/ui.dart';
import '../../drivers/utils/app_popups.dart';
import '../../drivers/utils/firebase_paths.dart';
import '../models/promoted_images_model.dart';

class PromotedAdsController extends GetxController {
  var isLoading = false.obs;
  RxList<Promotions?> promotionAdsList = <Promotions?>[].obs;

  void loadPromotions() {
    isLoading.value = true;
    FirebaseFirestore.instance
        .collection(FirebasePathNodes.promotionAds)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      isLoading.value = false;
      promotionAdsList.clear();
      for (var element in snapshot.docs) {
        Promotions? promotion =
            Promotions.fromMap(element.data() as Map<String, dynamic>);
        promotionAdsList.add(promotion);
      }
    });
  }

  void uploadImageWeb(Uint8List unit8listImage) async {
    String id = const Uuid().v1();
    AppPopUps.displayTextInputDialog(
        title: "Alert",
        message: "Enter Ad name",
        hint: "name here",
        onSubmit: (String? value) async {
          if ((value ?? "").isNotEmpty) {
            isLoading.value = true;
            String url = await FirebaseHelper().uploadImageWeb(
                file: unit8listImage,
                fileName: id,
                path: FirebasePathNodes.promotionAds);
            Promotions promotions =
                Promotions(id: id, imageUrl: url, name: value ?? '-');
            bool result = await FirebaseHelper().saveDocument(
                FirebasePathNodes.promotionAds, promotions.toMap());
            isLoading.value = false;
            if (result) {
              Get.showSnackbar(
                  Ui.SuccessSnackBar(message: "Ad saved successfully"));
            } else {
              Get.showSnackbar(Ui.ErrorSnackBar(message: "Failed to save ad"));
            }
          }
        });
  }

  void uploadImageFile(File file) async {
    String id = const Uuid().v1();
    AppPopUps.displayTextInputDialog(
        title: "Alert",
        message: "Enter Ad name",
        hint: "name here",
        onSubmit: (String? value) async {
          if ((value ?? "").isNotEmpty) {
            isLoading.value = true;
            String url = await FirebaseHelper().uploadImage(
                file: file, fileName: id, path: FirebasePathNodes.promotionAds);
            Promotions promotions =
                Promotions(id: id, imageUrl: url, name: value ?? "-");
            bool result = await FirebaseHelper().saveDocument(
                FirebasePathNodes.promotionAds, promotions.toMap());
            isLoading.value = false;
            if (result) {
              Get.showSnackbar(
                  Ui.SuccessSnackBar(message: "Ad saved successfully"));
            } else {
              Get.showSnackbar(Ui.ErrorSnackBar(message: "Failed to save ad"));
            }
          }
        });
  }

  void deleteItem({required Promotions model}) {
    AppPopUps.showConfirmDialog(
        title: "Confirm",
        message: "Are you sure to delete?",
        onSubmit: () async {
          Get.back(result: false);
          isLoading.value = true;
          await FirebaseHelper()
              .deleteDocument(FirebasePathNodes.promotionAds, model.toMap());
          await FirebaseHelper().deleteImage(
              id: model.id ?? '', fullPath: FirebasePathNodes.promotionAds);
          isLoading.value = false;
        });
  }
}
