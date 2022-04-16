import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/models/BlogsModel.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../drivers/utils/utils.dart';

class AdminAddNewBlogController extends GetxController {
  var loading = false.obs;

  TextEditingController placeNameController = TextEditingController();
  TextEditingController placeAddressController = TextEditingController();
  TextEditingController placeDescriptionController = TextEditingController();
  TextEditingController locationPickController = TextEditingController();
  RxList<File> picturesListMobile = <File>[].obs;
  RxList<Uint8List> picturesListWeb = <Uint8List>[].obs;
  RxList<String> feature = <String>[].obs;
  RxList<String> networkImageList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void setPlace(BlogModel? updatedModel) async {
    loading.value = true;

    BlogModel blogModel = BlogModel()
      ..id = const Uuid().v1()
      ..placeName = placeNameController.text
      ..placeAddress = placeAddressController.text
      ..placeDescription = placeDescriptionController.text
      ..placeFeatures = feature;
    uploadImagesToFireStorage(onComplete: (List<String> imagesUrls) async {
      ///adding network images in its method
      blogModel.placeImages = imagesUrls;
      bool result = false;
      if (updatedModel == null) {
        result = await FirebaseHelper()
            .saveDocument(FirebasePathNodes.blogs, blogModel.toMap());
      } else {
        blogModel.id = updatedModel.id ?? '';
        result = await FirebaseHelper()
            .updateDocument(FirebasePathNodes.blogs, blogModel.toMap());
      }

      loading.value = false;
      if (result) {
        Get.back();
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: "Blog saved successfully"));
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Failed to save blog"));
      }
    });
  }

  void uploadImagesToFireStorage({required onComplete}) async {
    List<String> imagesUrl = networkImageList;

    if (kIsWeb) {
      await Future.forEach(picturesListWeb, (element) async {
        String url = await FirebaseHelper().uploadImageWeb(
            file: element as Uint8List,
            fileName: element.lengthInBytes.toString(),
            path: FirebasePathNodes.blogs +
                "/" +
                element.lengthInBytes.toString() +
                "/");
        imagesUrl.add(url);
      });
    } else {
      await Future.forEach(picturesListMobile, (element) async {
        String url = await FirebaseHelper().uploadImage(
            file: element as File,
            fileName: basename((element).path),
            path:
                FirebasePathNodes.blogs + "/" + basename((element).path + "/"));
        imagesUrl.add(url);
      });
    }

    printWrapped('on Complete called');
    onComplete(imagesUrl);
  }

  void setValuesWithUpdate(BlogModel blogModel) {
    placeNameController.text = blogModel.placeName ?? '';
    placeAddressController.text = blogModel.placeAddress ?? '';
    placeDescriptionController.text = blogModel.placeDescription ?? '';

    blogModel.placeImages?.forEach((element) {
      networkImageList.add(element);
    });
    blogModel.placeFeatures?.forEach((element) {
      feature.add(element);
    });
  }

  void resetState() {
    placeNameController.clear();
    placeAddressController.clear();
    placeDescriptionController.clear();
    locationPickController.clear();
    picturesListMobile.clear();
    picturesListWeb.clear();
    feature.clear();
    networkImageList.clear();
    loading.value = false;
  }
}
