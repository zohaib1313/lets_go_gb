// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/add_new_vehicle_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';
import 'package:let_go_gb/modules/drivers/utils/app_popups.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

import '../../utils/common_widgets.dart';

class DriverAddNewVehiclePage extends GetView<AddNewVehicleController> {
  DriverAddNewVehiclePage({Key? key}) : super(key: key);
  static const id = '/DriverAddNewVehiclePage';
  final vSpace = SizedBox(height: 20.h);
  final _formKey = GlobalKey<FormState>();
  VehicleModel? vehicleModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetX<AddNewVehicleController>(
      initState: (state) {
        if (vehicleModel != null) {
          controller.setUpdatedValues(vehicleModel!);
        }
      },
      builder: (_) {
        controller.temp.value;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Container(
                  color: AppColor.blackColor.withAlpha(100),
                  padding: EdgeInsets.all(20.h),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                          vSpace,
                          Expanded(
                            child: Card(
                              color: AppColor.whiteColor.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 20,
                              child: Padding(
                                padding: EdgeInsets.all(20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vehicleModel == null
                                          ? "Add Your Vehicle"
                                          : "Update Your Vehicle",
                                      style: AppTextStyles
                                          .textStyleBoldSubTitleLarge,
                                    ),
                                    Expanded(
                                        child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            vSpace,
                                            getTextField(
                                                title: 'Vehicle Name',
                                                controller: controller
                                                    .vehicleNameController),
                                            vSpace,
                                            getTextField(
                                                title: 'Vehicle Plate No',
                                                controller: controller
                                                    .vehicleNoController),
                                            vSpace,
                                            getTextField(
                                                title: 'Vehicle Maker',
                                                controller: controller
                                                    .vehicleMakerController),
                                            vSpace,
                                            getTextField(
                                                title: 'Vehicle Make',
                                                controller: controller
                                                    .vehicleMakeController),
                                            vSpace,
                                            getTextField(
                                                title: 'Rent / Hour',
                                                hintText:
                                                    'Rent in rupees/ Hour',
                                                keyBoardType:
                                                    TextInputType.number,
                                                controller: controller
                                                    .vehicleRentHourController),
                                            vSpace,
                                            getTextField(
                                                title: 'Mileage / Liter',
                                                keyBoardType:
                                                    TextInputType.number,
                                                controller: controller
                                                    .vehicleMileageController),
                                            vSpace,
                                            getTextField(
                                                title:
                                                    'Vehicle Description Notes',
                                                minLines: 3,
                                                maxLines: 5,
                                                controller: controller
                                                    .vehicleNotesDescriptionController),
                                            vSpace,
                                            MyDropDown(
                                              fillColor: AppColor.alphaGrey,
                                              labelText: 'Seating Capacity',
                                              hintText: 'Select',
                                              items: controller
                                                  .seatingCapacityList,
                                              value: controller
                                                  .selectedSeatCapacity.value,
                                              validator: (value) {
                                                return null;
                                              },
                                              onChange: (value) {
                                                controller.selectedSeatCapacity
                                                    .value = value;
                                              },
                                            ),
                                            vSpace,
                                            MyDropDown(
                                              fillColor: AppColor.alphaGrey,
                                              labelText: 'Transmission Type',
                                              hintText: 'Select',
                                              items: controller
                                                  .transMissionTypeList,
                                              value: controller
                                                  .selectedTransmissionType
                                                  .value,
                                              validator: (value) {
                                                return null;
                                              },
                                              onChange: (value) {
                                                controller
                                                    .selectedTransmissionType
                                                    .value = value;
                                              },
                                            ),
                                            vSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Features",
                                                  style: AppTextStyles
                                                      .textStyleBoldBodyMedium,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      AppPopUps
                                                          .displayTextInputDialog(
                                                              title: "Feature",
                                                              message:
                                                                  "Please enter feature",
                                                              hint: "Feature",
                                                              onSubmit: (String
                                                                  text) {
                                                                if (text
                                                                    .isNotEmpty) {
                                                                  controller
                                                                      .feature
                                                                      .add(
                                                                          text);
                                                                }
                                                              });
                                                    },
                                                    child: Icon(Icons.add)),
                                              ],
                                            ),
                                            vSpace,
                                            if (controller.feature.isNotEmpty)
                                              Obx(
                                                () => SizedBox(
                                                  height: 90.h,
                                                  child: ListView.builder(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount: controller
                                                        .feature.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        width: 400.w,
                                                        height: 60.h,
                                                        decoration: BoxDecoration(
                                                            color: AppColor
                                                                .alphaGrey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .feature
                                                                      .removeAt(
                                                                          index);
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .cancel_outlined,
                                                                  color: AppColor
                                                                      .redColor,
                                                                  size: 17,
                                                                ),
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                controller
                                                                        .feature[
                                                                    index],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                              "Gallery",
                                              style: AppTextStyles
                                                  .textStyleBoldSubTitleLarge,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "upload recent pictures of your vehicle",
                                                  style: AppTextStyles
                                                      .textStyleNormalBodyXSmall,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      controller.showPicker(
                                                        context: context,
                                                      );
                                                    },
                                                    child:
                                                        const Icon(Icons.add)),
                                              ],
                                            ),
                                            vSpace,
                                            Obx(
                                              () => SizedBox(
                                                height: 150.h,
                                                child: Row(
                                                  children: [
                                                    ///network
                                                    Flexible(
                                                      child: ListView.builder(
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemCount: controller
                                                            .networkImageList
                                                            .length,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            width: 400.w,
                                                            height: 100.h,
                                                            decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .alphaGrey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Stack(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(7),
                                                                    child: NetworkPlainImage(
                                                                        url: controller
                                                                            .networkImageList[index]),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      controller
                                                                          .networkImageList
                                                                          .removeAt(
                                                                              index);
                                                                    },
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .cancel_outlined,
                                                                      color: AppColor
                                                                          .redColor,
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
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemCount: controller
                                                            .picturesList
                                                            .length,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            width: 400.w,
                                                            height: 100.h,
                                                            decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .alphaGrey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Stack(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(7),
                                                                    child: Image
                                                                        .file(
                                                                      controller
                                                                              .picturesList[
                                                                          index],
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      controller
                                                                          .picturesList
                                                                          .removeAt(
                                                                              index);
                                                                    },
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .cancel_outlined,
                                                                      color: AppColor
                                                                          .redColor,
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
                                            Button(
                                              buttonText: vehicleModel == null
                                                  ? "Submit"
                                                  : "Update",
                                              textColor: AppColor.whiteColor,
                                              color:
                                                  AppColor.primaryBlueDarkColor,
                                              onTap: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (controller.picturesList
                                                          .isEmpty &&
                                                      controller
                                                          .networkImageList
                                                          .isEmpty) {
                                                    Get.showSnackbar(
                                                        Ui.ErrorSnackBar(
                                                            message:
                                                                "Add Some Pictures Of Vehicle"));
                                                  } else if (controller
                                                      .feature.isEmpty) {
                                                    Get.showSnackbar(
                                                        Ui.ErrorSnackBar(
                                                            message:
                                                                'Add Some Features Of Vehicle'));
                                                  } else {
                                                    controller.saveVehicle(
                                                        vehicleModel);
                                                  }
                                                }
                                              },
                                            ),
                                            vSpace,
                                            vSpace,
                                            vSpace,
                                            vSpace,
                                            vSpace,
                                            vSpace,
                                            vSpace,
                                            vSpace,
                                          ],
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      if (controller.loading.value) LoadingWidget(),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  getTextField(
      {required String title,
      required TextEditingController controller,
      String? hintText,
      int minLines = 1,
      int maxLines = 1,
      TextInputType keyBoardType = TextInputType.text}) {
    return MyTextField(
      fillColor: AppColor.alphaGrey,
      hintText: hintText ?? title,
      minLines: minLines,
      maxLines: maxLines,
      leftPadding: 0,
      rightPadding: 0,
      keyboardType: keyBoardType,
      labelText: title,
      controller: controller,
      validator: (string) {
        if (string == null || string.isEmpty) {
          return 'Enter ${title}';
        }
        return null;
      },
    );
  }
}
