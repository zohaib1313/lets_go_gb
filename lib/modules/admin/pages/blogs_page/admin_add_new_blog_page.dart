import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/spaces.dart';
import 'package:let_go_gb/modules/admin/controller/admin_add_new_blog_controller.dart';
import 'package:let_go_gb/modules/admin/models/BlogsModel.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/utils/Utils.dart';

import '../../../drivers/common_widgets/ui.dart';
import '../../../drivers/utils/app_popups.dart';
import '../../../drivers/utils/utils.dart';

class AdminAddNewBlogPage extends GetView<AdminAddNewBlogController> {
  AdminAddNewBlogPage({Key? key}) : super(key: key);
  static const id = '/AdminAddNewBlogPage';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BlogModel? blogModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetX<AdminAddNewBlogController>(initState: (state) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        controller.resetState();
        if (blogModel != null) {
          controller.setValuesWithUpdate(blogModel!);
        }
      });
    }, builder: (x) {
      return Scaffold(
        appBar: myAppBar(
            title: blogModel != null ? 'Update Blog' : 'Add new blog',
            goBack: true),
        body: SafeArea(
            child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Container(
                  width: kIsWeb ? 600 : context.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vSpace,
                        vSpace,
                        Text(
                          "Gallery",
                          style: AppTextStyles.textStyleBoldSubTitleLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "upload some pictures of place",
                              style: AppTextStyles.textStyleNormalBodyXSmall,
                            ),
                            InkWell(
                                onTap: () {
                                  if (!kIsWeb) {
                                    AppUtils.showPicker(
                                        context: context,
                                        onComplete: (file) {
                                          controller.picturesListMobile
                                              .add(file);
                                        });
                                  } else {
                                    AppUtils.pickWebImage(
                                        onCompleteWebUnit8List:
                                            (Uint8List unit8List) {
                                      controller.picturesListWeb.add(unit8List);
                                    });
                                  }
                                },
                                child: const Icon(Icons.add)),
                          ],
                        ),
                        vSpace,
                        Obx(
                          () => SizedBox(
                            height: 150.h,
                            child: Row(
                              children: [
                                ///network
                                if (controller.networkImageList.isNotEmpty)
                                  Flexible(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount:
                                          controller.networkImageList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: NetworkPlainImage(
                                                  width: 150,
                                                  url: controller
                                                      .networkImageList[index],
                                                  fit: BoxFit.fill,
                                                )),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.networkImageList
                                                        .removeAt(index);
                                                  },
                                                  child: const Icon(
                                                    Icons.cancel_outlined,
                                                    color: AppColor.redColor,
                                                    size: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                ///local
                                Flexible(
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: kIsWeb
                                        ? controller.picturesListWeb.length
                                        : controller.picturesListMobile.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: kIsWeb
                                                    ? Image.memory(
                                                        controller
                                                                .picturesListWeb[
                                                            index],
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.file(
                                                        controller
                                                                .picturesListMobile[
                                                            index],
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  kIsWeb
                                                      ? controller
                                                          .picturesListWeb
                                                          .removeAt(index)
                                                      : controller
                                                          .picturesListMobile
                                                          .removeAt(index);
                                                },
                                                child: const Icon(
                                                  Icons.cancel_outlined,
                                                  color: AppColor.redColor,
                                                  size: 17,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        vSpace,
                        vSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Features",
                              style: AppTextStyles.textStyleBoldBodyMedium,
                            ),
                            InkWell(
                                onTap: () {
                                  AppPopUps.displayTextInputDialog(
                                      title: "Feature",
                                      message: "Please enter feature",
                                      hint: "Feature",
                                      onSubmit: (String text) {
                                        if (text.isNotEmpty) {
                                          controller.feature.add(text);
                                        }
                                      });
                                },
                                child: const Icon(Icons.add)),
                          ],
                        ),
                        vSpace,
                        if (controller.feature.isNotEmpty)
                          Obx(
                            () => SizedBox(
                              height: 90.h,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.feature.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 400.w,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                        color: AppColor.alphaGrey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller.feature
                                                  .removeAt(index);
                                            },
                                            child: const Icon(
                                              Icons.cancel_outlined,
                                              color: AppColor.redColor,
                                              size: 17,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            controller.feature[index],
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles
                                                .textStyleBoldBodyXSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        vSpace,
                        Text(
                          "Details",
                          style: AppTextStyles.textStyleBoldBodyMedium,
                        ),
                        vSpace,
                        vSpace,
                        vSpace,
                        MyTextField(
                          controller: controller.placeNameController,
                          rightPadding: 0,
                          leftPadding: 0,
                          hintText: "Place Name",
                          focusBorderColor: AppColor.primaryBlueColor,
                          unfocusBorderColor: AppColor.primaryBlueColor,
                          validator: (string) {
                            if ((string ?? "").isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                        vSpace,
                        MyTextField(
                          controller: controller.placeAddressController,
                          hintText: "Place Address",
                          rightPadding: 0,
                          leftPadding: 0,
                          focusBorderColor: AppColor.primaryBlueColor,
                          unfocusBorderColor: AppColor.primaryBlueColor,
                          validator: (string) {
                            if ((string ?? "").isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                        vSpace,
                        MyTextField(
                          controller: controller.placeDescriptionController,
                          hintText: "Place Description",
                          rightPadding: 0,
                          leftPadding: 0,
                          focusBorderColor: AppColor.primaryBlueColor,
                          minLines: 4,
                          maxLines: 8,
                          unfocusBorderColor: AppColor.primaryBlueColor,
                          validator: (string) {
                            if ((string ?? "").isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                        vSpace,
                        vSpace,
                        vSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                    (blogModel != null) ? "Update" : "Submit"),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (controller.picturesListWeb.isEmpty &&
                                      controller.picturesListMobile.isEmpty &&
                                      controller.networkImageList.isEmpty) {
                                    Get.showSnackbar(Ui.ErrorSnackBar(
                                        message: "Add Some Pictures Of Place"));
                                  } else if (controller.feature.isEmpty) {
                                    Get.showSnackbar(Ui.ErrorSnackBar(
                                        message: 'Add Some Features Of Place'));
                                  } else {
                                    controller.setPlace(blogModel);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                        vSpace,
                        vSpace,
                        vSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (controller.loading.isTrue) LoadingWidget()
          ],
        )),
      );
    });
  }
}
